//
//  PatientDetailsHeaderCell.swift
//  Santhera
//
//  Created by james on 18/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class PatientDetailsHeaderCell: UITableViewCell {
    @IBOutlet weak var lblBadge: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLastTestDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setObj(obj: Any){
        if let patient = obj as? Patient{
            self.lblName.text = "\(patient.firstname) \(patient.lastname)"
        }
    }
    class func getHeight() -> CGFloat {
        return 180
    }
}
