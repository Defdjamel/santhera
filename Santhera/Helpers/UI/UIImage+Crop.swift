//
//  UIImage+Crop.swift
//  Santhera
//
//  Created by james on 30/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

extension UIImage {
    func croppedInRect2(rect: CGRect) -> UIImage {
        let h =  self.size.height
        let w = self.size.width
        
        UIGraphicsBeginImageContext(CGSize(width: w,height: h))
        self.draw(in: CGRect(x:0, y:0, width: w, height: h))
        
        let smallImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let cropRect = rect
        let imageRef  = smallImage?.cgImage?.cropping(to: cropRect)
        let img = UIImage.init(cgImage: imageRef!)
        return img
    }
}
