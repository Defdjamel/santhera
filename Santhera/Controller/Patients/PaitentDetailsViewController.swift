//
//  PaitentDetailsViewController.swift
//  Santhera
//
//  Created by james on 18/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class PaitentDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let PatientsListTestCellId = "PatientsListTestCell"
    private let PatientDetailsHeaderCellId = "PatientDetailsHeaderCell"
    private let PatientResumeTestCellId = "PatientResumeTestCell"
    
    var currentPatient : Patient!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure(){
        self.title = L("patient_details_title")
        self.tableView.register(UINib.init(nibName: PatientsListTestCellId, bundle: Bundle.main), forCellReuseIdentifier: PatientsListTestCellId)
        self.tableView.register(UINib.init(nibName: PatientDetailsHeaderCellId, bundle: Bundle.main), forCellReuseIdentifier: PatientDetailsHeaderCellId)
        self.tableView.register(UINib.init(nibName: PatientResumeTestCellId, bundle: Bundle.main), forCellReuseIdentifier: PatientResumeTestCellId)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PaitentDetailsViewController: UITableViewDataSource, UITableViewDelegate{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return  currentPatient.testsLeftEye.count > 0 ? 1 : 0
        case 4:
            return  currentPatient.testsRightEye.count > 0 ? 1 : 0
        default:
            return 1
        }
        
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientDetailsHeaderCellId, for: indexPath) as! PatientDetailsHeaderCell
            // Configure the cell...
            cell.setObj(obj: currentPatient)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientResumeTestCellId, for: indexPath) as! PatientResumeTestCell
            // Configure the cell...
            cell.setObj(obj: currentPatient, type: .eye)
            return cell
        }
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientResumeTestCellId, for: indexPath) as! PatientResumeTestCell
            // Configure the cell...
            cell.setObj(obj: currentPatient, type: .firstTest)
           
            return cell
        }
        if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientsListTestCellId, for: indexPath) as! PatientsListTestCell
            // Configure the cell...
            cell.setTests(tests: currentPatient.testsRightEye)
            cell.lblTitle.text = L("patient_test_eye_right")
            return cell
        }
        if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientsListTestCellId, for: indexPath) as! PatientsListTestCell
            // Configure the cell...
             cell.lblTitle.text = L("patient_test_eye_left")
             cell.setTests(tests: currentPatient.testsLeftEye)
            return cell
        }
        return UITableViewCell.init()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return PatientDetailsHeaderCell.getHeight()
        case 1:
            return PatientResumeTestCell.getHeight()
        case 2:
            return PatientResumeTestCell.getHeight()
        case 3:
            return PatientsListTestCell.getHeight()
        case 4:
            return PatientsListTestCell.getHeight()
       
        default:
            return 0
        }
    }
}