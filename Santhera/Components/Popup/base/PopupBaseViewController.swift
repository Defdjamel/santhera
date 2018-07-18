//
//  PopupBaseViewController.swift
//  Santhera
//
//  Created by james on 16/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class PopupBaseViewController: UIViewController,UIGestureRecognizerDelegate {
    var window : UIWindow = UIApplication.shared.keyWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.alpha=0;
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        self.view.frame = window.bounds
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissHandle(recognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showViewFromCtrl(controller: UIViewController){
        self.showView()
        controller.addChildViewController(self)
    }
    func showView(){
        let mainWindow : UIWindow = UIApplication.shared.keyWindow!
        mainWindow.addSubview(self.view)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha=1.0;
        })
    }
    
    func dismissView(){
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha=0;
        }) { (true) in
            self.view.removeFromSuperview()
        }
    }

    // MARK: - Actions
    @objc func dismissHandle(recognizer : UITapGestureRecognizer)
    {
        //dismissView()
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
