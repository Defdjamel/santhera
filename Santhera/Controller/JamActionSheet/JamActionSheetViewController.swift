//
//  JamActionSheetViewController.swift
//  Santhera
//
//  Created by james on 20/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
struct jamActionSheetBtn {
    public var name: String
    public var colorText: UIColor
    public var fontText: UIFont
    public var colorBackground: UIColor
}

protocol JamActionSheetDelegate {
    func jamActionSheetViewCellXibName(_ JamActionSheet: JamActionSheetViewController) -> String
    func jamActionSheetViewCellHeight(_ JamActionSheet: JamActionSheetViewController, Object: Any) -> CGFloat
    func JamActionSheet(_ JamActionSheet: JamActionSheetViewController, DidSelect indexPath: IndexPath)
}


class JamActionSheetViewController: UIViewController {
    typealias SelectBlock = ( _ object : Any,  _ sender : JamActionSheetViewController ) -> ()
    typealias CancelBlock = (  _ sender : JamActionSheetViewController ) -> ()

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var heightActionSheetView: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actionSheetView: UIView!
    var jamActionSheetCollectionViewCellId = ""
    var objects : Array<Any> = []
    var delegate : JamActionSheetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.frame = (UIApplication.shared.keyWindow?.bounds)!
        addGestureRecognizer()
        jamActionSheetCollectionViewCellId = (self.delegate?.jamActionSheetViewCellXibName(self))!
         self.collectionView.register(UINib.init(nibName: jamActionSheetCollectionViewCellId , bundle: Bundle.main), forCellWithReuseIdentifier: jamActionSheetCollectionViewCellId )
        
    }
   
    func addGestureRecognizer(){
        let tapGestureRecognizer =  UITapGestureRecognizer(target: self, action: #selector(handleGesture(recognizer:)))
        self.backgroundView.addGestureRecognizer(tapGestureRecognizer)
    }
   @objc func handleGesture(recognizer: UITapGestureRecognizer){
    slideOut {
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func show(fromCtrl: UIViewController, obj: Array<Any>){
    
        objects = obj
       
        fromCtrl.view.addSubview(self.view)
        fromCtrl.addChildViewController(self)
        slideIn()
       
    }
    func updateHeightActionSheeView(){
        self.collectionView.reloadData()
        self.collectionView.performBatchUpdates(nil, completion: {
            (result) in
            self.heightActionSheetView.constant = self.collectionView.contentSize.height
            self.actionSheetView.updateConstraints()
        })
      
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
        updateHeightActionSheeView()
        self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
        }) { (finish) in
           
        }
    }
    
    func slideOut(finishAnim: @escaping () -> Void){
        var frame = self.actionSheetView.frame
        frame.origin = CGPoint(x: 0, y: self.view.bounds.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.actionSheetView.frame = frame
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
        }) { (finish) in
             self.view.removeFromSuperview()
             self.removeFromParentViewController()
            finishAnim()
        }
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          self.collectionView.register(UINib.init(nibName: jamActionSheetCollectionViewCellId , bundle: Bundle.main), forCellWithReuseIdentifier: jamActionSheetCollectionViewCellId )
  
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: jamActionSheetCollectionViewCellId ,
                                                      for: indexPath) as! JActionSheetCollectionViewCell
        cell.setObj(obj: objects[indexPath.row])
        
        return cell
    }
    
}
extension JamActionSheetViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.slideOut {
            self.delegate?.JamActionSheet(self, DidSelect: indexPath)
        }
        
     
    }
}
extension JamActionSheetViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = self.delegate?.jamActionSheetViewCellHeight(self, Object: objects[indexPath.row])
        return CGSize(width: CGFloat(view.bounds.width), height: CGFloat(h!))
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0 , left: 0.0 , bottom: 0.0, right: 0.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

