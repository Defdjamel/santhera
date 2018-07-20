//
//  JamActionSheetViewController.swift
//  Santhera
//
//  Created by james on 20/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

protocol JamActionSheetDelegate {
    func jamActionSheetViewCellXibName(_ JamActionSheet: JamActionSheetViewController) -> String
    func jamActionSheetViewCellHeight(_ JamActionSheet: JamActionSheetViewController, Object: Any) -> CGFloat
}


class JamActionSheetViewController: UIViewController {
    typealias SelectBlock = ( _ object : Any,  _ sender : JamActionSheetViewController ) -> ()
    typealias CancelBlock = (  _ sender : JamActionSheetViewController ) -> ()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionSheetView: UIView!
    var delegate : JamActionSheetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.frame = (UIApplication.shared.keyWindow?.bounds)!
        addGestureRecognizer()
        
    }
    func addGestureRecognizer(){
        let tapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(handleGesture(recognizer:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
   @objc func handleGesture(recognizer: UITapGestureRecognizer){
    slideOut()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func show(fromCtrl: UIViewController){
        fromCtrl.view.addSubview(self.view)
        fromCtrl.addChildViewController(self)
        slideIn()
    }
    func slideIn(){
        var frame = self.actionSheetView.frame
        frame.origin = CGPoint(x: 0, y: self.view.bounds.height)
        self.actionSheetView.frame = frame
        let animation = CATransition()
        animation.duration = 0.3
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromTop
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.view.alpha = 1.0
        self.actionSheetView.layer.add(animation, forKey: "slideInAnimation")
    }
    
    func slideOut(){
        var frame = self.actionSheetView.frame
        frame.origin = CGPoint(x: 0, y: self.view.bounds.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.actionSheetView.frame = frame
        }) { (finish) in
             self.view.removeFromSuperview()
             self.removeFromParentViewController()
        }
    }
    
    @objc func animationDidStop(animationId: String, context: CGContext){
        self.view.removeFromSuperview()
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
extension JamActionSheetViewController: UICollectionViewDataSource{
    
}
extension JamActionSheetViewController: UICollectionViewDelegate{
    
}
extension JamActionSheetViewController: UICollectionViewDelegateFlowLayout{
    
}

