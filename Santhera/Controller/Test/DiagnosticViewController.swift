//
//  DiagnosticViewController.swift
//  Santhera
//
//  Created by james on 30/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
private let DiagCaptureCellId = "DiagCaptureCell"
private let DiagDateCellId = "DiagDateCell"
private let DiagSelectEyeCellCellId = "DiagSelectEyeCellCell"
private let DiagSelectPatientCellId = "DiagSelectPatientCell"


class DiagnosticViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var currentTest: Test!
   
    var imageCropped  : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: DiagCaptureCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagCaptureCellId)
        self.tableView.register(UINib.init(nibName: DiagDateCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagDateCellId)
        self.tableView.register(UINib.init(nibName: DiagSelectEyeCellCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagSelectEyeCellCellId)
        self.tableView.register(UINib.init(nibName: DiagSelectPatientCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagSelectPatientCellId)
       
      
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - UITableViewDataSource
extension DiagnosticViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagCaptureCellId, for: indexPath) as! DiagCaptureCell
            cell.setTest(test: currentTest)
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagDateCellId, for: indexPath) as! DiagDateCell
            cell.setTest(test: currentTest)
            return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagSelectEyeCellCellId, for: indexPath) as! DiagSelectEyeCellCell

            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagSelectPatientCellId, for: indexPath) as! DiagSelectPatientCell
            
            return cell
        }
       
        return UITableViewCell.init()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        
        switch indexPath.row {
        case 0:
            return DiagCaptureCell.getHeight()
        case 1:
            return DiagDateCell.getHeight()
        case 2:
            return DiagSelectEyeCellCell.getHeight()
        case 3:
            return DiagSelectPatientCell.getHeight()
        default:
            return 0
        }
    }
}
extension DiagnosticViewController:   UITableViewDelegate{

}
