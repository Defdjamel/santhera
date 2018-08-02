//
//  DiagEditPatientCell.swift
//  Santhera
//
//  Created by james on 01/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

protocol DiagEditPatientCellDelegate {
    func diagEditPatientCell(DidRemovePatient DiagEditPatientCell: DiagEditPatientCell)
}

class DiagEditPatientCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLastTest: UILabel!
    var delegate : DiagEditPatientCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPatient(patient: Patient){
         self.lblName.text = "\(patient.firstname) \(patient.lastname)"
        
        if let date = patient.getLastTestFormatedDate() {
            self.lblLastTest.text = L("last_test_date") + " : " + date
            
        }else {
           lblLastTest.text = ""
        }
    }
    @IBAction func onClickBtnRemove(_ sender: Any) {
        delegate?.diagEditPatientCell(DidRemovePatient: self)
    }
    class func getHeight() -> CGFloat {
        return 180
    }
}
