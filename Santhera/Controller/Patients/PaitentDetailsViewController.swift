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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension PaitentDetailsViewController: UITableViewDataSource, UITableViewDelegate{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientDetailsHeaderCellId, for: indexPath) as! PatientDetailsHeaderCell
            // Configure the cell...
            cell.setObj(obj: currentPatient)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientsListTestCellId, for: indexPath) as! PatientsListTestCell
            // Configure the cell...
            
            return cell
        }
        return UITableViewCell.init()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return PatientDetailsHeaderCell.getHeight()
        case 1:
            return PatientsListTestCell.getHeight()
       
        default:
            return 0
        }
    }
}
