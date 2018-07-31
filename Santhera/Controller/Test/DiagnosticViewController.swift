//
//  DiagnosticViewController.swift
//  Santhera
//
//  Created by james on 30/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class DiagnosticViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    var imageCropped  : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imgView.image = imageCropped
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
