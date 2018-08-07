//
//  InstructionStepCell.swift
//  Santhera
//
//  Created by james on 06/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class InstructionStepCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
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
    
    func setStep(step: InstructionStep){
        self.lblTitle.text = step.title
        self.lblSubtitle.text = step.subtitle
        self.imgView.image = UIImage.init(named: step.imageName)
    }
}
