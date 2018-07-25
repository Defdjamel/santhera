//
//  UITextFieldExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 23/03/2015.
//  Copyright (c) 2015 Muxu.Muxu. All rights reserved.
//

#if os(iOS)

import UIKit

public extension UITextField {
    public func selectText(at range: NSRange) {
        if let start = position(from: beginningOfDocument, offset: range.location) {
            if let end = position(from: start, offset: range.length) {
                selectedTextRange = textRange(from: start, to: end)
            }
        }
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
#endif
