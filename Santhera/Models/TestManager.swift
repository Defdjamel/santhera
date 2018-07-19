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
   
    func createTestObjects(){
        removeAll()
        for i in 1...10 {
            let test = Test()
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(test)
            test.date =  Date().addingTimeInterval(TimeInterval(i * -60))
            test.patient = DataManager.sharedInstance.getAllPatients().first
            test.isLeftEye = (i % 2 == 0 ? true: false)
            try! realm.commitWrite()
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
