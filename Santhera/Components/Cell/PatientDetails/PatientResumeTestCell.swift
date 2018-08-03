//
//  PatientResumeTestEyeCell.swift
//  Santhera
//
//  Created by james on 18/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

enum resumeType: Int {
    case eye
    case firstTest
    case patient
}

class PatientResumeTestCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setObj(obj: Any, type: resumeType){
        guard let patient = obj as? Patient else{
            return
        }
        
        switch type {
        case .eye:
            configureEye(patient: patient)
        case .firstTest:
            configureFirstTest(patient: patient)
        default:
            return
            
        }
    }
    func setTest(test: Test,type: resumeType){
        if type == .eye {
            configureTestEye(test: test)
        }
        if type == .patient {
            configureTestPatient(test: test)
        }
    }
    func configureEye(patient: Patient){
        self.lblTitle.text = L("patient_resume_eye")
        //eye test
        if patient.hasRightEyeTest() &&  patient.hasLeftEyeTest()  {
            self.lblSubtitle.text = L("patient_test_eye_right") + " & " + L("patient_test_eye_left")
        }
        else if patient.hasLeftEyeTest() {
             self.lblSubtitle.text = L("patient_test_eye_left")
        }
        else  if patient.hasRightEyeTest() {
            self.lblSubtitle.text = L("patient_test_eye_right")
        }
        else {// no test
            self.lblSubtitle.text = L("patient_test_no_eye")
        }
        
        self.imgLogo.image = #imageLiteral(resourceName: "icEyes")
    }
    func configureFirstTest(patient: Patient){
        self.lblTitle.text = L("patient_resume_first_test")
        //1st Test
        let df = DateFormatter()
        df.dateStyle = .medium
        if let test  = patient.tests.last {
            self.lblSubtitle.text =  df.string(from: test.date!)
        }
        else {
            self.lblSubtitle.text = L("patient_test_no_eye")
        }
        
        self.imgLogo.image = #imageLiteral(resourceName: "icFirstTest")
    }
    
    func configureTestEye(test: Test){
        self.imgLogo.image = #imageLiteral(resourceName: "icPatient_2")
         self.lblTitle.text = L("patient_resume_eye")
        if test.isLeftEye {
            self.lblSubtitle.text = L("patient_test_eye_left")
        }else{
             self.lblSubtitle.text = L("patient_test_eye_right")
        }
    }
    func configureTestPatient(test: Test){
        self.imgLogo.image = #imageLiteral(resourceName: "icEyes")
        guard let patient =  test.patient else {
            return
        }
        self.lblTitle.text = L("test_resume_patient")
        self.lblSubtitle.text = "\(patient.firstname) \(patient.lastname)"
    }
    class func getHeight() -> CGFloat {
        return 44
    }
}
