//
//  PatientsListTestCell.swift
//  Santhera
//
//  Created by james on 18/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
private let heightCollectionView = 180.0
private var PatientTestResumeCollectionViewCellId = "PatientTestResumeCollectionViewCell"
private let heightCell = 140.0
private let widthCell = 140.0
class PatientsListTestCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    var testsPatient : Array<Test> = []
    @IBOutlet weak var btnTestNumber: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib.init(nibName: PatientTestResumeCollectionViewCellId , bundle: Bundle.main), forCellWithReuseIdentifier: PatientTestResumeCollectionViewCellId )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    class func getHeight() -> CGFloat {
        return CGFloat(heightCollectionView + 48.0)
    }
    func setTests(tests:  Array<Test>){
        self.btnTestNumber.setTitle("\(tests.count) " + L("test_numbers"), for: .normal)
        testsPatient = tests
        self.collectionView.reloadData()
    }
    
    //MARK: - Action -
    @IBAction func onClickSeeMore(_ sender: Any) {
        
    }
    
    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return testsPatient.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PatientTestResumeCollectionViewCellId ,
                                                      for: indexPath) as! PatientTestResumeCollectionViewCell
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(widthCell), height: CGFloat(heightCell ))
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 00.0 , left: 20.0 , bottom: 0.0, right: 20.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
}
