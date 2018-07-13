//
//  HomeDocumentCollectionViewCell.swift
//  Santhera
//
//  Created by james on 13/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class HomeDocumentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setObj(obj: Any){
        if let document = obj as? Document{
            self.lblSubtitle.text = document.name
            //thumb
            self.imgView.image = UIImage.init(contentsOfFile: document.thumb_url)
        }
    }

}
