//
//  PopupGenericViewController.swift
//  Santhera
//
//  Created by james on 23/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
struct popupGenerecBtn {
    public var id: String
    public var name: String
    public var colorText: UIColor
    public var fontText: UIFont
    public var colorBackground: UIColor
}
class PopupGenericViewController: PopupBaseViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var btnContainerView: UIView!
    @IBOutlet weak var iconImg: UIImageView!
    typealias SelectBlock = ( _ object : popupGenerecBtn,  _ sender : PopupGenericViewController ) -> ()
    typealias CancelBlock = (  _ sender : PopupGenericViewController ) -> ()
    
    var doneBlock : SelectBlock! = nil
    var cancelBlock : CancelBlock! = nil
    
    var titleText = ""
    var subtitleText = ""
    var iconimage = #imageLiteral(resourceName: "icAlerte")
    var buttonArray : [popupGenerecBtn] =  []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configure(){
        self.lblTitle.text = titleText
        self.lblSubtitle.text = subtitleText
        self.iconImg.image = iconimage
        
        let w : CGFloat = self.btnContainerView.bounds.width / buttonArray.count
        let h : CGFloat = self.btnContainerView.bounds.height
        var xPos : CGFloat = 0
        var tag = 0
        //button
        for button in buttonArray{
            let btn = UIButton()
            btn.tag = tag
            btn.backgroundColor = button.colorBackground
            btn.setTitleColor(button.colorText, for: .normal)
            btn.setTitle(button.name, for: .normal)
            btn.titleLabel?.font = button.fontText
            btn.frame = CGRect(x: CGFloat( xPos), y: CGFloat(0), width: w, height: h)
            self.btnContainerView.addSubview(btn)
            btn.addTarget(self, action: #selector(onClickBtn), for: .touchUpInside)
            xPos = xPos + w
            tag = tag + 1
        }
        
        
    }
    @objc func onClickBtn(sender: Any){
        print("click")
        if let btn = sender as? UIButton {
           doneBlock(buttonArray[btn.tag],self)
        }
    }
    
    func showWithTitle(title: String, subtitle:String, icon: UIImage, buttons: [popupGenerecBtn] , fromCtrl: UIViewController,
                       done: @escaping SelectBlock, cancel: @escaping CancelBlock){
        doneBlock = done
        cancelBlock = cancel
        
        titleText = title
        subtitleText = subtitle
        iconimage = icon
        buttonArray = buttons
        self.showViewFromCtrl(controller: fromCtrl)
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
