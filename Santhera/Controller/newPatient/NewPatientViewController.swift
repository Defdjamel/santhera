//
//  NewPatientViewController.swift
//  Santhera
//
//  Created by james on 23/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class NewPatientViewController: UIViewController {
    var currentPatient : Patient?

    @IBOutlet weak var btnValidateBottomConstaint: NSLayoutConstraint!
    @IBOutlet weak var btnValidate: buttonValidate!
    @IBOutlet weak var txtfFirstName: UITextField!
    @IBOutlet weak var txtfName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
        addKeyboardObs()
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configure(){
        textFieldNoEditMode(textField : self.txtfName)
        textFieldNoEditMode(textField : self.txtfFirstName)
        //inset textFiedl
        txtfName.setLeftPaddingPoints(20)
        txtfFirstName.setLeftPaddingPoints(20)
        
        if currentPatient != nil {
            title = L("edit_patient_title")
            txtfFirstName.text = currentPatient?.firstname
            txtfName.text  = currentPatient?.lastname
            
        }else{
            title = L("new_patient_title")
        }
       self .updateView()
       
        txtfName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        txtfFirstName.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    func updateView(){
        if self.txtfName.text?.count > 0  && self.txtfFirstName.text?.count > 0 {
            self.btnValidate.isEnabled = true
        }
        else {
            self.btnValidate.isEnabled = false
        }
    }
    
    @IBAction func onClickBtnValidate(_ sender: Any) {
        if currentPatient != nil {//edit
            currentPatient?.updatePatient(firstName: txtfFirstName.text!, lastName: txtfName.text!)
        }
        else{//new
           currentPatient =  PatientManager.sharedInstance.createPatient(firstName: txtfFirstName.text!, lastName: txtfName.text!)
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func addKeyboardObs(){
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func textFieldEditMode(textField: UITextField){
        textField.backgroundColor = UIColor.paleBlue
        textField.layer.borderColor = UIColor.cobalt.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        textField.layer.shadowColor = UIColor.windowsBlue.cgColor
        textField.layer.shadowRadius = 8
        textField.layer.shadowOffset =  CGSize(width: 4, height: 4)
        textField.layer.shadowOpacity = 0.2
        textField.textColor = UIColor.windowsBlue
    }
    func textFieldNoEditMode(textField: UITextField){
        textField.backgroundColor = UIColor.paleGrey
        textField.layer.borderColor = UIColor.cobalt.cgColor
        textField.layer.cornerRadius = 0
        textField.layer.borderWidth = 0
        textField.layer.shadowRadius = 0
        textField.layer.shadowOpacity = 0
        textField.textColor = UIColor.gray
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


extension NewPatientViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.textFieldEditMode(textField: textField)
        }
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
          UIView.animate(withDuration: 0.3) {
            self.textFieldNoEditMode(textField: textField)
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateView()
    }
    
}

//MARK: - Keyboard
extension NewPatientViewController {
    
    @objc open func keyboardWillShow(_ notification: Foundation.Notification) {
        if let rectValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let kbRect = view.convert(rectValue.cgRectValue, from: nil)
            btnValidateBottomConstaint.constant = -1 * kbRect.size.height
        }
    }
    @objc open func keyboardWillHide(_ notification: Foundation.Notification) {
        btnValidateBottomConstaint.constant = 0
    }
    
}
