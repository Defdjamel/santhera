//
//  BotMessageCell.swift
//  Santhera
//
//  Created by james on 09/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class BotMessageCell: UITableViewCell {
    @IBOutlet weak var lblText: UILabel!
    
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Private methods
     func setNodeBot(botNode:  BotNode){
    self.lblText.text = L(botNode.key)
    }
}
