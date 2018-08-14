//
//  BotDocumentsCell.swift
//  Santhera
//
//  Created by james on 14/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class BotDocumentCell: UITableViewCell {

    @IBOutlet weak var imgDocuments: UIImageView!
    
    //MARK: - lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - public methods
    func setNodeBot(botNode: BotNode){
        if  let document = DocumentManager.sharedInstance.getDocumentWithName(key: botNode.arg) {
            self.imgDocuments.image = UIImage.init(contentsOfFile: document.thumb_url)
        }
        else {
            self.imgDocuments.image = nil
        }
    }
}
