//
//  Patient.swift
//  Santhera
//
//  Created by james on 12/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift
class Patient: Object {
    let tests = LinkingObjects(fromType: Test.self, property: "patient")
    @objc dynamic var firstname = ""
    @objc dynamic var lastname = ""
   
    @objc dynamic var id = 0
    override static func primaryKey() -> String? {
        return "id"
    }

    var testsLeftEye: Array<Test> { // read-only properties are automatically ignored
        let predicate =  NSPredicate(format: "isLeftEye = true ")
        return Array(self.tests.filter(predicate))
    }
    var testsRightEye: Array<Test> { // read-only properties are automatically ignored
        let predicate =  NSPredicate(format: "isLeftEye = false ")
        return Array(self.tests.filter(predicate))
    }
    
    func hasLeftEyeTest() -> Bool{
        let predicate =  NSPredicate(format: "isLeftEye = true ")
        return self.tests.filter(predicate).count > 0 ? true : false
        
    }
    func hasRightEyeTest() -> Bool{
        let predicate =  NSPredicate(format: "isLeftEye = false ")
        return self.tests.filter(predicate).count > 0 ? true : false
    }
    
    
    func removePatientAndData(){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self.tests)
            realm.delete(self)
        }
    }
    
    func updatePatient( firstName: String, lastName: String){
        let realm = try! Realm()
        realm.beginWrite()
        self.lastname = lastName
        self.firstname = firstName
        try! realm.commitWrite()
    }
    
    func getLastTestFormatedDate() -> String?{
        if self.tests.count > 0 {
            let df = DateFormatter()
            df.dateStyle = .medium
            return  df.string(from: (self.tests.first?.date)!)
        }
        else {
            return nil
        }
    }
    
    class func incrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(Patient.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
