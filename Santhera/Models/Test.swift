//
//  Test.swift
//  Santhera
//
//  Created by james on 18/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift
class Test: Object {
        @objc dynamic var patient: Patient?
        @objc dynamic var date : Date? = nil
        @objc dynamic var isLeftEye : Bool = true //default Left
        @objc dynamic var file_name = ""
        @objc dynamic var comment = ""

    var imageUrl: URL? { // read-only properties are automatically ignored
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(self.file_name)
            return fileURL
        }
        return nil
    }
    
    func remove(){
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
}
