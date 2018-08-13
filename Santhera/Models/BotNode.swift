//
//  BotNode.swift
//  Santhera
//
//  Created by james on 09/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift

enum NodeType: String {
    case message = "m"
    case document = "d"
    case question = "s"
    case questionChoice = "o"
    case stop = "b"
}
class BotNode : Object {
    @objc dynamic var key = ""
    @objc dynamic var type  = NodeType.message.rawValue // default message
    @objc dynamic var arg = ""
    @objc dynamic var goto = ""
    @objc dynamic var parent = ""

}
