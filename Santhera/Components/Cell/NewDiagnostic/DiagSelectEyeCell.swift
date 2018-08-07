//
//  DiagSelectEyeCellCell.swift
//  Santhera
//
//  Created by james on 31/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
protocol DiagSelectEyeCellDelegate {
    func diagSelectEyeCell(_ diagSelectEyeCell: DiagSelectEyeCell, DidSelectIsEyeLeft value: Bool)
}

class DiagSelectEyeCell: UITableViewCell {

    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    var delegate : DiagSelectEyeCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initButtonState()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func getHeight() -> CGFloat {
        return 85
    }
    
    //MARK: - private methods
    private func initButtonState(){
        deSelectButton(button: self.btnLeft)
        deSelectButton(button: self.btnRight)
    }
    private func selectButton(button: UIButton){
        button.backgroundColor = UIColor.windowsBlue
        button.isSelected = true
    }
    private func deSelectButton(button: UIButton){
        button.backgroundColor = UIColor.paleGrey
         button.isSelected = false
    }
    //MARK: - IBAction
    @IBAction func onClickLeft(_ sender: Any) {
        selectButton(button: self.btnLeft)
        deSelectButton(button: self.btnRight)
        self.delegate?.diagSelectEyeCell(self, DidSelectIsEyeLeft: true)
    }
    @IBAction func onClickRight(_ sender: Any) {
        selectButton(button: self.btnRight)
        deSelectButton(button: self.btnLeft)
        self.delegate?.diagSelectEyeCell(self, DidSelectIsEyeLeft: false)
    }
}
