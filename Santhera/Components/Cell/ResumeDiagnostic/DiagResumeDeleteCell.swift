//
//  DiagResumeDeleteCell.swift
//  Santhera
//
//  Created by james on 02/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class DiagResumeDeleteCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let  attrs = [
            kCTUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue]
        let attributeString = NSMutableAttributedString(string: lblTitle.text!,
                                                        attributes: attrs as [NSAttributedStringKey : Any])
        lblTitle.attributedText = attributeString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    class func getHeight()-> CGFloat {
        return 44
    }
}
