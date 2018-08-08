//
//  Document.swift
//  Santhera
//
//  Created by james on 12/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift
class Document: Object {
     @objc dynamic var type = DocumentType.image.rawValue
     @objc dynamic var name = ""
     @objc dynamic var file_name = ""
     @objc dynamic var thumb_name = ""
     @objc dynamic var isReaded = false
    
    var file_url: String { // read-only properties are automatically ignored
       return Bundle.main.path(forResource: self.file_name, ofType: nil)!
    }
    var thumb_url: String { // read-only properties are automatically ignored
        return Bundle.main.path(forResource: self.thumb_name, ofType: nil)!
    }
}

enum DocumentType: String {
    case pdf = "pdf"
    case image = "image"
}
