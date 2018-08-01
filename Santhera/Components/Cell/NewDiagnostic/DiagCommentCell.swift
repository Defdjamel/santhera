//
//  DiagCommentCell.swift
//  Santhera
//
//  Created by james on 01/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class DiagCommentCell: UITableViewCell {
    @IBOutlet weak var txtView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setTest(test: Test){
        
    }
    class func getHeight() -> CGFloat {
        return 180
    }
}

