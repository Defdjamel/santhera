//
//  PatientTestResumeCollectionViewCell.swift
//  Santhera
//
//  Created by james on 19/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

class PatientTestResumeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgTest: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setTest(test: Test){
        let df =  DateFormatter()
        df.dateFormat = "E d MMMM"
        self.lblDate.text = df.string(from: test.date!)
        df.timeStyle = .short
        df.dateStyle = .none
        self.lblTime.text = df.string(from: test.date!)
        //self.imgTest.image = UIImage.init(named: test.file_name)
       self.imgTest.image =  UIImage.init(contentsOfFile: (test.imageUrl?.path)! )
        
    }

}
