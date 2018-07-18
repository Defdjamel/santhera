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
   

}
