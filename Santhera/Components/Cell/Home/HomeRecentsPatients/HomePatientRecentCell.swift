//
//  HomePatientRecentCell.swift
//  Santhera
//
//  Created by james on 12/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
private var HomePatientCollectionViewCellId = "HomePatientCollectionViewCell"
private let heightPatientCell = 150.0

protocol HomePatientRecentCellDelegate {
    func  homePatientRecentCellDidSelectMore(_ homePatientRecentCell: HomePatientRecentCell)
    func  homePatientRecentCell(_ homePatientRecentCell: HomePatientRecentCell, DidSelectPatient patient: Patient )
}


class HomePatientRecentCell: UITableViewCell , UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var collectionView: UICollectionView!
    var patients : Array<Patient> = []
    var delegate : HomePatientRecentCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib.init(nibName: HomePatientCollectionViewCellId , bundle: Bundle.main), forCellWithReuseIdentifier: HomePatientCollectionViewCellId )
        self.collectionView.reloadData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func getHeight() -> CGFloat {
        return CGFloat(heightPatientCell + 60.0)
    }
    
    //MARK: - Action -
    @IBAction func onClickSeeMore(_ sender: Any) {
        self.delegate?.homePatientRecentCellDidSelectMore(self)
    }
    
    //MARK: - UICollectionViewDataSource -
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return patients.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePatientCollectionViewCellId ,
                                                      for: indexPath) as! HomePatientCollectionViewCell
        cell.setObj(obj: patients[indexPath.row])
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: heightPatientCell, height: heightPatientCell)
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
       self.delegate?.homePatientRecentCell(self, DidSelectPatient: patients[indexPath.row])
    }
    
    
}
