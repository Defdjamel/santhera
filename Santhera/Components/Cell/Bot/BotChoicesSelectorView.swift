    //
//  BotChoicesSelectorView.swift
//  Santhera
//
//  Created by james on 10/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
    
protocol BotChoicesSelectorViewDelegate {
  func BotChoicesSelectorView(_ botChoicesSelectorView: BotChoicesSelectorView, DidSelect botNode: BotNode)
}

class BotChoicesSelectorView: UIView {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var botNodes : [BotNode] = []
    var delegate : BotChoicesSelectorViewDelegate?
    
    //MARK:  - Private Methods
    
    //MARK:  - Public Methods
    func setChoices(choices: [BotNode]){
        self.scrollView.removeAllSubviews()
        scrollView.isPagingEnabled = true
        botNodes = choices
        let w : CGFloat = scrollView.bounds.width//200
        let h : CGFloat = scrollView.bounds.height - self.pageControl.bounds.height
        var x : CGFloat = 0
        let y : CGFloat = 0
        var i = 0
        for node in botNodes {
            let choiceView = BotChoiceView.instanceFromNib() as! BotChoiceView
            choiceView.frame = CGRect(x: x, y: y, width: w, height: h)
            choiceView.setChoice(choice: node)
            scrollView.addSubview(choiceView)
            let btn = UIButton.init()
            btn.frame = choiceView.frame
            scrollView.addSubview(btn)
            btn.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
            btn.tag = i
            i += 1
            x += w
        }
        self.pageControl.numberOfPages = i
        scrollView.contentSize = CGSize(width: x, height: 0)
        
    }
    
    @objc func onClickButton(sender: Any){
        guard let btn =  sender as? UIButton else {
            return
        }
        self.delegate?.BotChoicesSelectorView(self, DidSelect: botNodes[btn.tag])
        
    }
}
extension BotChoicesSelectorView : UIScrollViewDelegate{
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageWidth = scrollView.frame.size.width
            let page = NSInteger( floor( scrollView.contentOffset.x / pageWidth) )
            if self.pageControl.currentPage != page {
                self.pageControl.currentPage = page
                if page == 0 {
                    
                }
                else{
                    
                }
            }
    }
}
    
