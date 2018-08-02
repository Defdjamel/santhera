//
//  DiagnosticResumeViewController.swift
//  Santhera
//
//  Created by james on 02/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
private let DiagCaptureCellId = "DiagCaptureCell"
private let DiagDateCellId = "DiagDateCell"
private let PatientResumeTestCellId = "PatientResumeTestCell"
private let DiagResumeCommentCellId = "DiagResumeCommentCell"
private let DiagResumeDeleteCellId = "DiagResumeDeleteCell"




class DiagnosticResumeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var currentTest: Test!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib.init(nibName: DiagCaptureCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagCaptureCellId)
        self.tableView.register(UINib.init(nibName: DiagDateCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagDateCellId)
        self.tableView.register(UINib.init(nibName: PatientResumeTestCellId, bundle: Bundle.main), forCellReuseIdentifier: PatientResumeTestCellId)
        self.tableView.register(UINib.init(nibName: DiagResumeCommentCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagResumeCommentCellId)
        self.tableView.register(UINib.init(nibName: DiagResumeDeleteCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagResumeDeleteCellId)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
     //MARK: - Private methods
    private func showAlertDelete(){
        
        let alert = PopupGenericViewController()
        alert.showWithTitle(title: L("popup_delete_test_title"), subtitle: L("popup_delete_test_subtitle"), icon: #imageLiteral(resourceName: "icAlerte"),
                            buttons: [ popupGenerecBtn.init(id: "cancel", name: L("patient_delete_cancel_btn"), colorText: UIColor.cobalt, fontText: UIFont.systemFont(ofSize: 18, weight: .bold ), colorBackground: UIColor.white), popupGenerecBtn.init(id: "delete", name: L("patient_delete_confirm_btn"), colorText: UIColor.white, fontText: UIFont.systemFont(ofSize: 18, weight: .bold ), colorBackground: UIColor.cobalt)]
            , fromCtrl: self, done: { (buttonSelected, ctrl) in
                
                ctrl.dismissView()
                if buttonSelected.id == "delete" {
                    self.currentTest.remove()
                    self.navigationController?.popViewController(animated: true)
                }
                
        }) { (ctrl) in
        }
    }
    
     //MARK: - IBAction
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension DiagnosticResumeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientResumeTestCellId, for: indexPath) as! PatientResumeTestCell
            cell.setTest(test: currentTest, type: .eye)
            return cell
        }
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PatientResumeTestCellId, for: indexPath) as! PatientResumeTestCell
            cell.setTest(test: currentTest, type: .patient)
            return cell
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagResumeCommentCellId, for: indexPath) as! DiagResumeCommentCell
                cell.setTest(test: currentTest)
            return cell
        }
        if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagResumeDeleteCellId, for: indexPath) as! DiagResumeDeleteCell
            return cell
        }
        
      
        
        
        return UITableViewCell.init()
    }
    
   
}
extension DiagnosticResumeViewController:   UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 5 {
            showAlertDelete()
        }
    }
}
