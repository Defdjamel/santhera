//
//  ResultViewController.swift
//  Santhera
//
//  Created by Santhera on 04/05/2018.
//  Copyright © 2018 Bien Ouej. All rights reserved.
//

import UIKit
import Photos

class ResultViewController: UIViewController {
    var image: UIImage!
    let wrapper = OpenCVWrapper()
    
    @IBOutlet fileprivate var resultImageView: UIImageView!
}

extension ResultViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: true)
        let processedImage = wrapper.processImage(image)
        resultImageView.image = processedImage?.rotate(radians: .pi/2)
    }
    
    func saveImageToPhotoLibrary(image: UIImage?) {
        guard let image = image else { return }
        try? PHPhotoLibrary.shared().performChangesAndWait {
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }
    }
}

extension ResultViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return resultImageView
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
