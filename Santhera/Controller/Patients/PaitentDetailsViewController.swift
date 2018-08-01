//
//  PaitentDetailsViewController.swift
//  Santhera
//
//  Created by james on 18/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class PaitentDetailsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let PatientsListTestCellId = "PatientsListTestCell"
    private let PatientDetailsHeaderCellId = "PatientDetailsHeaderCell"
    private let PatientResumeTestCellId = "PatientResumeTestCell"
    
    var currentPatient : Patient!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func configure(){
        self.title = L("patient_details_title")
        self.tableView.register(UINib.init(nibName: PatientsListTestCellId, bundle: Bundle.main), forCellReuseIdentifier: PatientsListTestCellId)
        self.tableView.register(UINib.init(nibName: PatientDetailsHeaderCellId, bundle: Bundle.main), forCellReuseIdentifier: PatientDetailsHeaderCellId)
        self.tableView.register(UINib.init(nibName: PatientResumeTestCellId, bundle: Bundle.main), forCellReuseIdentifier: PatientResumeTestCellId)
        self.addRightButton()
    
    }

    func addRightButton(){
       let  menu_button_ = UIBarButtonItem(image: #imageLiteral(resourceName: "icSettings"),
                                           style: UIBarButtonItemStyle.plain ,
                                           target: self, action:  #selector(OnMenuClicked) )
        menu_button_.tintColor = UIColor.cobalt
       self.navigationItem.rightBarButtonItem =  menu_button_
    }
    
    @objc func OnMenuClicked(){
        let actionSheetCtrl =  JamActionSheetViewController()
        actionSheetCtrl.delegate = self
        let object =  [jamActionSheetBtn.init(name: L("patient_edit_btn") ,colorText: UIColor.white,fontText: UIFont.systemFont(ofSize: 18, weight: .semibold ), colorBackground:UIColor.cobalt ),
                       jamActionSheetBtn.init(name:  L("patient_delete_btn"),colorText: UIColor.white,fontText: UIFont.systemFont(ofSize: 18, weight: .semibold ), colorBackground:UIColor.windowsBlue),
                       jamActionSheetBtn.init(name:  L("patient_cancel_btn"),colorText: UIColor.cobalt, fontText: UIFont.systemFont(ofSize: 18, weight: .bold ),colorBackground:UIColor.white)]
        actionSheetCtrl.show(fromCtrl: self.navigationController!,obj:object)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showAlertDelete(){
      
        let alert = PopupGenericViewController()
        alert.showWithTitle(title: L("popup_delete_patient_title"), subtitle: L("popup_delete_patient_subtitle"), icon: #imageLiteral(resourceName: "icAlerte"),
                        buttons: [ popupGenerecBtn.init(id: "cancel", name: L("patient_delete_cancel_btn"), colorText: UIColor.cobalt, fontText: UIFont.systemFont(ofSize: 18, weight: .bold ), colorBackground: UIColor.white), popupGenerecBtn.init(id: "delete", name: L("patient_delete_confirm_btn"), colorText: UIColor.white, fontText: UIFont.systemFont(ofSize: 18, weight: .bold ), colorBackground: UIColor.cobalt)]
            , fromCtrl: self, done: { (buttonSelected, ctrl) in
                
                ctrl.dismissView()
                if buttonSelected.id == "delete" {
                    self.currentPatient.removePatientAndData()
                    self.navigationController?.popViewController(animated: true)
                }
            
        }) { (ctrl) in
            
        }
    }
    func goToEditPatientCtrl(){
        self.performSegue(withIdentifier: "editPatient", sender: self)
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? NewPatientViewController {
                vc.currentPatient = currentPatient
            
        }
    }
    
}
//MARK: - UITableViewDelegate
extension PaitentDetailsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
//MARK: - UITableViewDataSource
extension PaitentDetailsViewController: UITableViewDataSource {
   
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
//MARK: - JamActionSheetDelegate
extension PaitentDetailsViewController: JamActionSheetDelegate{
    func JamActionSheet(_ JamActionSheet: JamActionSheetViewController, DidSelect indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            self.showAlertDelete()
        case 0:
            self.goToEditPatientCtrl()
        default:
           return
        }
    }
    
    func jamActionSheetViewCellXibName(_ JamActionSheet: JamActionSheetViewController) -> String {
        return "JCustomActionSheetCell"
    }
    func jamActionSheetViewCellHeight(_ JamActionSheet: JamActionSheetViewController, Object: Any) -> CGFloat {
        return 60.0
    }
}
