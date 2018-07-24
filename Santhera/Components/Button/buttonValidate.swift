//
//  buttonValidate.swift
//  Santhera
//
//  Created by james on 24/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class buttonValidate: UIButton {

    
        override open var isEnabled : Bool {
            willSet{
                if newValue == false {
                     UIView.animate(withDuration: 0.3) {
                        self.setTitleColor(UIColor.white, for: UIControlState.disabled)
                        self.alpha = 0.5
                    }
                }
                if newValue == true {
                    UIView.animate(withDuration: 0.3) {
                        self.setTitleColor(UIColor.white, for: UIControlState.disabled)
                        self.alpha = 1
                    }
                    
                }
            }
        }
    

}
