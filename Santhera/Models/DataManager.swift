//
//  DataManager.swift
//  Santhera
//
//  Created by james on 12/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift
class DataManager: NSObject {
    static let sharedInstance = DataManager()
    
    //MARK: -  Documents
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
                document.file_url =   Bundle.main.path(forResource: file_name, ofType: nil)!
            }
            if let thumb_name = item.object(forKey: "thumbnail") as? String {
                document.thumb_url =  Bundle.main.path(forResource: thumb_name, ofType: nil)!
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
                    DataManager.sharedInstance.createOrUpdateDocuments(items: documents)
                }else {// handle error parsing
                    print("documents.json  parsing json failed!")
                }
            } catch {
                // handle error
                print("documents.json opening  failed!")
            }
        }
        
        
    }
   //MARK: - Patients
    func getRecentPatients() -> Array<Patient> {
         let realm = try! Realm()
        let p = realm.objects(Patient.self)
        return Array(p)
    }
    func getAllPatients() -> Array<Patient> {
        let realm = try! Realm()
        let p = realm.objects(Patient.self).sorted(byKeyPath: "lastname", ascending: false)
        return Array(p)
    }
    func getAllPatientsFilterText(text: String) -> Array<Patient> {
        let realm = try! Realm()
        let predicate =  NSPredicate(format: "self.lastname contains [cd] '\(text)' or self.firstname contains [cd] '\(text)' ")
        let p = realm.objects(Patient.self).filter(predicate).sorted(byKeyPath: "lastname", ascending: false)
        return Array(p)
    }
    
    func createTestUsers(){
        removeAllPatients()
        for i in 1...10 {
            let patient = Patient()
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(patient)
            patient.firstname =  "prénom \(i)"
            patient.lastname =  "nom \(i)"
            try! realm.commitWrite()
        }
    }
    func removeAllPatients(){
        let realm = try! Realm()
        let d = realm.objects(Patient.self)
        try! realm.write {
            realm.delete(d)
        }
    }
}
