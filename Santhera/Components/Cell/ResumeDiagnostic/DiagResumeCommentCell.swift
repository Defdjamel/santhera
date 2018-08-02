//
//  DiagResumeCommentCell.swift
//  Santhera
//
//  Created by james on 02/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class DiagResumeCommentCell: UITableViewCell {

    @IBOutlet weak var lblComment: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setTest(test: Test){
        self.lblComment.text = test.comment
        if test.comment.count == 0 {
            self.lblComment.text = L("resume_test_no_comment")
        }
    }
    
    class func getHeight()-> CGFloat {
        return 180
    }
}
