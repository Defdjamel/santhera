//
//  HomePatientCollectionViewCell.swift
//  Santhera
//
//  Created by james on 12/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class HomePatientCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblBadge: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLastTestDate: UILabel!
    @IBOutlet weak var lblLastTestTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblLastTestTitle.text = L("last_test_date") + " :"
    }

    func setObj(obj: Any){
        
        if let patient = obj as? Patient{
            self.lblName.text = "\(patient.firstname) \(patient.lastname)"
            self.lblBadge.text = "\(patient.tests.count)"
            if let date = patient.getLastTestFormatedDate() {
                self.lblLastTestDate.text = date
                hideLastTest(value: false)
            }else {
                hideLastTest(value: true)
            }
        }
    }
    func hideLastTest(value: Bool){
        self.lblLastTestDate.isHidden = value
        self.lblLastTestTitle.isHidden = value
    }
}
