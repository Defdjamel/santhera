//
//  DiagnosticViewController.swift
//  Santhera
//
//  Created by james on 30/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import RealmSwift
private let DiagCaptureCellId = "DiagCaptureCell"
private let DiagDateCellId = "DiagDateCell"
private let DiagSelectEyeCellId = "DiagSelectEyeCell"
private let DiagSelectPatientCellId = "DiagSelectPatientCell"
private let DiagCommentCellId = "DiagCommentCell"
private let DiagEditPatientCellId = "DiagEditPatientCell"



class DiagnosticViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSave: buttonValidate!
    var currentTest: Test!
    var isEyeLeftSelect : Bool!
    var textCommentView : UITextView?
    //var imageCropped  : UIImage!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib.init(nibName: DiagCaptureCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagCaptureCellId)
        self.tableView.register(UINib.init(nibName: DiagDateCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagDateCellId)
        self.tableView.register(UINib.init(nibName: DiagSelectEyeCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagSelectEyeCellId)
        self.tableView.register(UINib.init(nibName: DiagSelectPatientCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagSelectPatientCellId)
        self.tableView.register(UINib.init(nibName: DiagCommentCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagCommentCellId)
        self.tableView.register(UINib.init(nibName: DiagEditPatientCellId, bundle: Bundle.main), forCellReuseIdentifier: DiagEditPatientCellId)
       
        updateBtnSave()
        addKeyboardObs()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - privates methods
    private func updateBtnSave(){
        if isEyeLeftSelect != nil, currentTest.patient != nil {
           self.btnSave.isEnabled = true
        }
        else {
            self.btnSave.isEnabled = false
        }
    }
   private func addKeyboardObs(){
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    private func hideKeyboard(){
        textCommentView?.resignFirstResponder()
    }
    
    // MARK: - IBActions
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onClickSave(_ sender: Any) {
         let realm = try! Realm()
         realm.beginWrite()
        if let comment = textCommentView?.text  {
            currentTest.comment = comment
        }
        realm.add(currentTest)
        try! realm.commitWrite()
        self.dismiss(animated: true, completion: nil)
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
        return 5
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
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagSelectEyeCellId, for: indexPath) as! DiagSelectEyeCell
            cell.delegate = self
            return cell
        }
        if indexPath.row == 3 {
            if let patient = currentTest.patient  {
                let cell = tableView.dequeueReusableCell(withIdentifier: DiagEditPatientCellId, for: indexPath) as! DiagEditPatientCell
                cell.setPatient(patient: patient)
                cell.delegate = self
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: DiagSelectPatientCellId, for: indexPath) as! DiagSelectPatientCell
                cell.delegate = self
                return cell
            }
        }
        if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DiagCommentCellId, for: indexPath) as! DiagCommentCell
            cell.txtView.delegate = self
            textCommentView =  cell.txtView
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
            return DiagSelectEyeCell.getHeight()
        case 3:
            return (currentTest.patient != nil) ?  DiagEditPatientCell.getHeight() : DiagSelectPatientCell.getHeight()
        case 4:
            return DiagCommentCell.getHeight()
        default:
            return 0
        }
    }
}
extension DiagnosticViewController:   UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hideKeyboard()
    }
}

//MARK: - Keyboard
extension DiagnosticViewController {
    
    @objc open func keyboardWillShow(_ notification: Foundation.Notification) {
        if let rectValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let kbRect = view.convert(rectValue.cgRectValue, from: nil)
            bottomConstraint.constant =  kbRect.size.height
            self.tableView.scrollToBottom()
        }
    }
    @objc open func keyboardWillHide(_ notification: Foundation.Notification) {
        bottomConstraint.constant = 0
    }
    
}
//MARK: - UITextViewDelegate
extension DiagnosticViewController : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView){
        print("text Change")
    }
}

//MARK: - DiagSelectEyeCellDelegate
extension DiagnosticViewController : DiagSelectEyeCellDelegate{
    func diagSelectEyeCell(_ diagSelectEyeCell: DiagSelectEyeCell, DidSelectIsEyeLeft value: Bool) {
        currentTest.isLeftEye = value
        isEyeLeftSelect = value
        self.hideKeyboard()
        self.updateBtnSave()
    }
}
//MARK: - DiagSelectEyeCellDelegate
extension DiagnosticViewController : DiagSelectPatientCellDelegate{
    func diagSelectPatientCell(DidSelectAddPatient diagSelectPatientCell: DiagSelectPatientCell) {
        let vc =  UIStoryboard(name: "Patients", bundle: nil).instantiateViewController(withIdentifier: "PatientsList") as! PatientsViewController
        vc.isPatientSelectable = true
        vc.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.show(vc, sender: self)
        self.hideKeyboard()
    }
    
    
}
//MARK: - PatientsViewControllerDelegate
extension DiagnosticViewController: PatientsViewControllerDelegate{
    func patientsViewController(_ patientsViewController: PatientsViewController, DidSelect patient: Patient) {
        patientsViewController.navigationController?.popViewController(animated: true)
        currentTest.patient = patient
        updateBtnSave()
        self.tableView.reloadData()
    }
    
    
}
extension DiagnosticViewController: DiagEditPatientCellDelegate {
    func diagEditPatientCell(DidRemovePatient DiagEditPatientCell: DiagEditPatientCell) {
        currentTest.patient = nil
        self.tableView.reloadData()
        updateBtnSave()
    }
    
    
}
