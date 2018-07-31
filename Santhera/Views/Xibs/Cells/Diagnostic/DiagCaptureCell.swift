//
//  DiagCaptureCell.swift
//  Santhera
//
//  Created by james on 31/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class DiagCaptureCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTest(test: Test){
        self.imgView.image = UIImage.init(contentsOfFile: (test.imageUrl?.path)! )
    }
    func setImage(image: UIImage){
        self.imgView.image = image
    }
    class func getHeight() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
}
