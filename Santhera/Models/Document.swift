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
     @objc dynamic var preview = ""
     @objc dynamic var isReaded = false
}

enum DocumentType: String {
    case pdf = "pdf"
    case image = "image"
}
