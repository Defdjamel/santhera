//
//  BotNodeManager.swift
//  Santhera
//
//  Created by james on 09/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift
class BotNodeManager: NSObject {
      static let sharedInstance = BotNodeManager()
    
    func updateBotFromJsonFile(){
        removeAll()
        for index in 1...2 {
            let nameFile = "step_\(index)"
            if let path = Bundle.main.path(forResource: nameFile, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonDict = jsonResult as? Array<NSDictionary> {
                        self.createOrUpdateBotNodes(items: jsonDict)
                    }else {// handle error parsing
                        print("parsing json failed!")
                    }
                } catch {
                    // handle error
                    print("opening  failed!")
                }
            }
            
        }
    }
    
    func createOrUpdateBotNodes(items: Array<NSDictionary>) {
       
        for item in items {
            _ = createOrUpdateBotNode(item: item)
        }
    }
    func createOrUpdateBotNode(item: NSDictionary) -> BotNode{
        let node = BotNode()
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(node)
        if let key = item.object(forKey: "key") as? String {
            node.key =  key
        }
       
        if let type = item.object(forKey: "type") as? String {
            if type ==  NodeType.message.rawValue {
                node.type =  NodeType.message.rawValue
            }
            
        }
        if let goto = item.object(forKey: "goto") as? String {
            node.goto =  goto
        }
        if let parent = item.object(forKey: "parent") as? String {
            node.parent =  parent
        }
        if let arg = item.object(forKey: "arg") as? String {
            node.arg =  arg
        }
        
        try! realm.commitWrite()
        return node
    }
    func getNodeWithKey(key: String) -> BotNode? {
        let realm = try! Realm()
        let predicate =  NSPredicate(format: "self.key = [cd] '\(key)'  ")
        
        guard let p = realm.objects(BotNode.self).filter(predicate).first  else {
            return nil
        }
        return p
        
    }
    
    
    func removeAll(){
        let realm = try! Realm()
        let d = realm.objects(BotNode.self)
        try! realm.write {
            realm.delete(d)
        }
    }
    
}
