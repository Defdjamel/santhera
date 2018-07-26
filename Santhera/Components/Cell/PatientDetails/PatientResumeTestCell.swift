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
    class func getHeight() -> CGFloat {
        return 44
    }
}
