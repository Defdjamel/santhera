//
//  JCustomActionSheetCell.swift
//  Santhera
//
//  Created by james on 20/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class JCustomActionSheetCell: JActionSheetCollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setObj(obj: Any){
        guard let obj = obj as? jamActionSheetBtn else{
            return
        }
        self.containerView.backgroundColor =  obj.colorBackground
        self.lblTitle.text  = obj.name
        self.lblTitle.font = obj.fontText
        self.lblTitle.textColor = obj.colorText
    }

}
