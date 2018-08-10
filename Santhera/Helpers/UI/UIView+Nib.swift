//
//  UIView+Nib.swift
//  Santhera
//
//  Created by james on 10/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
extension UIView{
    class func instanceFromNib() -> Any {
        return UINib(nibName: self.className, bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as Any
    }
    func removeAllSubviews(){
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
}
