//
//  DiagDateCell.swift
//  Santhera
//
//  Created by james on 31/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class DiagDateCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTest(test: Test){
        let df = DateFormatter()
        df.dateStyle  = .long
        if let date = test.date {
           lblDate.text = df.string(from:date)
        }
        
        
    }
    class func getHeight() -> CGFloat {
        return 50
    }
    
}
