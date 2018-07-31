//
//  TestManager.swift
//  Santhera
//
//  Created by james on 18/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift
class TestManager: NSObject {
    static let sharedInstance = TestManager()
    
    func createTestWithImage(image: UIImage, patient: Patient?) -> Test{
         let realm = try! Realm()
         realm.beginWrite()
        let test = Test()
        test.date  = Date()
        if patient != nil {
            
        }
        
        //save image to document directory
        let nameImage = "\(Date().timeIntervalSince1970)"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(nameImage)
            if let data = UIImagePNGRepresentation(image) {
              try? data.write(to: fileURL)
            }
         
            test.file_name = nameImage
        }
        try! realm.commitWrite()
        return test
    }
   
    func createTestObjects(){
        removeAll()
        var p = 0
        for patient in PatientManager.sharedInstance.getAllPatients() {
            let number = Int.random(lower: 3, upper: 10)
            let date = Date().addingTimeInterval(TimeInterval(p * -86400))
            for i in 1...number {
                let test = Test()
                let realm = try! Realm()
                realm.beginWrite()
                realm.add(test)
                test.date = date.addingTimeInterval(TimeInterval(i * -86400))
                test.patient = patient
                test.isLeftEye = (i % 2 == 0 ? true: false)
                test.file_name =  (i % 3 == 0 ?  "test_1.png":  "test_2.png")
                try! realm.commitWrite()
            }
            p += 1
        }
    }
    
    func removeAll(){
        let realm = try! Realm()
        let d = realm.objects(Test.self)
        try! realm.write {
            realm.delete(d)
        }
    }
}
