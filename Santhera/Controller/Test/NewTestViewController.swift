//
//  NewTestViewController.swift
//  Santhera
//
//  Created by james on 30/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class NewTestViewController: UIViewController {
    var imagePicker = UIImagePickerController()
    var currentTest: Test!

    @IBOutlet weak var cropGrid: UIImageView!
    @IBOutlet weak var cameraViewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        openCamera()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

     //MARK: - IBAction
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickTakePicture(_ sender: Any) {
        imagePicker.takePicture()
    }
    @IBAction func onClickInformation(_ sender: Any) {
    }
    
    // MARK: - Private Methods
    private func openCamera(){
        if !UIImagePickerController.isSourceTypeAvailable(.camera){
            print("camera not available!")
            return
        }
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.showsCameraControls = false
        imagePicker.allowsEditing = false
        cameraViewContainer.addSubview( imagePicker.view )
        imagePicker.view.frame = cameraViewContainer.bounds
        //full screen camera
        let screenSize = UIScreen.main.bounds.size
        let cameraAspectRatio = CGFloat(4.0 / 3.0)
        let cameraImageHeight = screenSize.width * cameraAspectRatio
        let scale = screenSize.height / cameraImageHeight
        imagePicker.cameraViewTransform = CGAffineTransform(translationX: 0, y: (screenSize.height - cameraImageHeight)/2)
        imagePicker.cameraViewTransform = imagePicker.cameraViewTransform.scaledBy(x: scale, y: scale)
        
    }
    private func createTest(image: UIImage){
        
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? DiagnosticViewController {
            vc.currentTest = currentTest
        }
    }

}

extension NewTestViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        print(info)
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let scale =   pickedImage.size.height / self.view.frame.height
            //cropimage
            let y = cropGrid.frame.origin.y  * scale
            let height =  cropGrid.frame.height * scale
            let x = pickedImage.size.width / 2 - ( cropGrid.frame.width/2 * scale)
            let width =  cropGrid.frame.width * scale
            let imageCropped =  pickedImage.croppedInRect2(rect: CGRect(x: x, y: y, width: width, height: height))
            print(imageCropped.size)
            currentTest = TestManager.sharedInstance.createTestWithImage(image: imageCropped, patient: nil)
            
            self.performSegue(withIdentifier: "diagnostic", sender: self)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
}

