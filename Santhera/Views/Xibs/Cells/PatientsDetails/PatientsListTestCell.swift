//
//  PatientsListTestCell.swift
//  Santhera
//
//  Created by james on 18/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
private let heightCollectionView = 150.0
class PatientsListTestCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func getHeight() -> CGFloat {
        return CGFloat(heightCollectionView + 48.0)
    }
    
    //MARK: - Action -
    @IBAction func onClickSeeMore(_ sender: Any) {
        
    }
}
