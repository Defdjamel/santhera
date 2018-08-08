//
//  DocumentManager.swift
//  Santhera
//
//  Created by james on 19/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift
class DocumentManager: NSObject {
     static let sharedInstance = DocumentManager()

    func getAllDocuments()-> Array<Document>{
        let realm = try! Realm()
        let d = realm.objects(Document.self)
        return Array(d)
    }
    func createOrUpdateDocuments(items: Array<NSDictionary>) {
        removeAllDocuments()
        for item in items {
            _ = createOrUpdateDocument(item: item)
        }
    }
    func createOrUpdateDocument(item: NSDictionary) -> Document{
        let document = Document()
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(document)
        if let name = item.object(forKey: "name") as? String {
            document.name =  name
        }
        if let file_name = item.object(forKey: "file") as? String {
            document.file_name =   file_name
        }
        if let thumb_name = item.object(forKey: "thumbnail") as? String {
            document.thumb_name = thumb_name
        }
        if let type = item.object(forKey: "type") as? String {
            if type ==  DocumentType.image.rawValue {
                document.type = DocumentType.image.rawValue
            }
            if type ==  DocumentType.pdf.rawValue {
                document.type = DocumentType.pdf.rawValue
            }
        }
        
        try! realm.commitWrite()
        return document
    }
    func removeAllDocuments(){
        let realm = try! Realm()
        let d = realm.objects(Document.self)
        try! realm.write {
            realm.delete(d)
        }
    }
    func updateJsonDocuments(){
        if let path = Bundle.main.path(forResource: "documents", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonDict = jsonResult as? Dictionary<String, AnyObject>, let documents =  jsonDict["documents"] as? Array<NSDictionary> {
                    DocumentManager.sharedInstance.createOrUpdateDocuments(items: documents)
                }else {// handle error parsing
                    print("documents.json  parsing json failed!")
                }
            } catch {
                // handle error
                print("documents.json opening  failed!")
            }
        }
        
        
    }
}
