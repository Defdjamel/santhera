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
    
    func createPatient(firstName: String, lastName: String) -> Patient{
        let patient = Patient()
        let realm = try! Realm()
        realm.beginWrite()
        patient.id = Patient.incrementID()
        realm.add(patient)
        patient.lastname = lastName
        patient.firstname = firstName
        
        try! realm.commitWrite()
        return patient
    }
    
    
    func getRecentPatients() -> Array<Patient> {
        let realm = try! Realm()
        let tests = realm.objects(Test.self).sorted(byKeyPath: "date", ascending: false)
        var users : Array<Patient> = []
        for t in tests {// remove double
            if !users.contains(t.patient!) , users.count < 5 {
                 users.append(t.patient!)
            }
        }
        return users
    }
    func getAllPatients() -> Array<Patient> {
        let realm = try! Realm()
        let p = realm.objects(Patient.self).sorted(byKeyPath: "lastname", ascending: true)
        return Array(p)
    }
    func getAllPatientsFilterText(text: String) -> Array<Patient> {
        let realm = try! Realm()
        let predicate =  NSPredicate(format: "self.lastname contains [cd] '\(text)' or self.firstname contains [cd] '\(text)' ")
        let p = realm.objects(Patient.self).filter(predicate).sorted(byKeyPath: "lastname", ascending: true)
        return Array(p)
    }
    
    func createTestUsers(){
        removeAllPatients()
        let usersTest =  [
        ["firstName":"Alberto","lastName":"BAGGIO"],
        ["firstName":"Joakim","lastName":"Fernando"],
        ["firstName":"Gigi","lastName":"L'AMOROSO"],
        ["firstName":"Kris","lastName":"Kross"],
        ["firstName":"Luka","lastName":"Modrić"],
        ["firstName":"PimPam","lastName":"POOM"],
        ["firstName":"Mickey","lastName":"Mouse"],
        ["firstName":"Gilbert","lastName":"Montagnet"],]
        for user in usersTest {
            let patient = Patient()
            let realm = try! Realm()
            realm.beginWrite()
            patient.id = Patient.incrementID()
            realm.add(patient)
            patient.firstname =  user["firstName"]!
            patient.lastname =   user["lastName"]!
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
