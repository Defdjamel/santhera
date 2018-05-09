//
//  ViewController.swift
//  Santhera
//
//  Created by Santhera on 02/05/2018.
//  Copyright © 2018 Bien Ouej. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    let cameraController = CameraController()
    
    @IBOutlet fileprivate var captureButton: UIButton!
    @IBOutlet fileprivate var captureZoneView: UIView!
    @IBOutlet fileprivate var capturePreviewView: UIView!
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(OpenCVWrapper.openCVVersionString())")
        
        func styleCaptureButton() {
            captureButton.layer.borderColor = UIColor.black.cgColor
            captureButton.layer.borderWidth = 2
            
            captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
        }
        
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error { print(error) }
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
        }
        
        styleCaptureButton()
        configureCameraController()
        
        captureZoneView.layer.borderColor = UIColor.green.cgColor
        captureZoneView.layer.borderWidth = 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func captureImage(_ sender: UIButton) {
        cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            
            let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            resultVC.image = image
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
    }
}
