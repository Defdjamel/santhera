//
//  DiagSelectPatientCell.swift
//  Santhera
//
//  Created by james on 31/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
protocol DiagSelectPatientCellDelegate {
    func diagSelectPatientCell(DidSelectAddPatient diagSelectPatientCell: DiagSelectPatientCell)
}

class DiagSelectPatientCell: UITableViewCell {
    var delegate : DiagSelectPatientCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - class methods
    class func getHeight() -> CGFloat {
        return 100
    }
    
    //MARK: - IBAction
    @IBAction func onClickSelectPatient(_ sender: Any) {
        self.delegate?.diagSelectPatientCell(DidSelectAddPatient: self)
    }
    
}
