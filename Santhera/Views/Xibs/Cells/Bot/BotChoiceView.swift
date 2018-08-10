//
//  BotChoiceView.swift
//  Santhera
//
//  Created by james on 10/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class BotChoiceView: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func setChoice(choice: BotNode){
        self.lblTitle.text = L(choice.key)
    }
}
