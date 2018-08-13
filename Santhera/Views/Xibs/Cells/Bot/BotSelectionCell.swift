//
//  BotSelectionCell.swift
//  Santhera
//
//  Created by james on 10/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class BotSelectionCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var editIcon: UIImageView!
    //MARK: - lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK: - public methods
    func setNodeBot(botNode: BotNode){
        self.lblTitle.text = L(botNode.key)
    }
    func setEditable(value: Bool){
        editIcon.isHidden = !value
    }
    //MARK: - private methods
    
    //MARK: - IBAction
    @IBAction func onClickEdit(_ sender: Any) {
    }
    
}
