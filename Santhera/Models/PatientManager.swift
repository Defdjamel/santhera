//
//  PatientManager.swift
//  Santhera
//
//  Created by james on 19/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift

class PatientManager: NSObject {
     static let sharedInstance = PatientManager()
    
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
