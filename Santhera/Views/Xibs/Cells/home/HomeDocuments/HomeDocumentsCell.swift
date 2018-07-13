//
//  HomeDocumentsCell.swift
//  Santhera
//
//  Created by james on 12/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
private var HomeDocumentCollectionViewCellId = "HomeDocumentCollectionViewCell"
private let heightCell = 140.0
private let widthCell = 100.0
class HomeDocumentsCell: UITableViewCell, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var documents : Array<Document> = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(UINib.init(nibName: HomeDocumentCollectionViewCellId , bundle: Bundle.main), forCellWithReuseIdentifier: HomeDocumentCollectionViewCellId )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    class func getHeight() -> CGFloat {
        return CGFloat(heightCell + 90.0)
    }
    
    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeDocumentCollectionViewCellId ,
                                                      for: indexPath) as! HomeDocumentCollectionViewCell
        cell.setObj(obj: documents[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CGFloat(widthCell), height: CGFloat(heightCell + 40.0))
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
