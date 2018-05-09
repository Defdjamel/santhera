//
//  HistoryViewController.swift
//  Santhera
//
//  Created by Santhera on 09/05/2018.
//  Copyright © 2018 Bien Ouej. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    var images: [Image] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let fetchedImages = PersistanceController.shared.fetchImages() {
            self.images = fetchedImages
        }
    }
    
    @IBAction func mergeImages(_ sender: Any) {
        var backgroundImage: UIImage?
        for image in images {
            if backgroundImage == nil {
                guard let path = image.path else { continue }
                backgroundImage = PersistanceController.shared.getPicture(Key: path)
                continue
            }
            
            guard let path = image.path else { continue }
            let frontImage = PersistanceController.shared.getPicture(Key: path)
            
            let size = view.frame.size
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            
            backgroundImage?.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
            frontImage?.draw(in: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            backgroundImage = newImage
        }
        
        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultVC.image = backgroundImage?.rotate(radians: -.pi/2)
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let title = images[indexPath.row].title, let path = images[indexPath.row].path else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
        cell.imageThumb.image = PersistanceController.shared.getPicture(Key: path)
        cell.imageTitle.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let path = images[indexPath.row].path else { return }

        let resultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultVC.image = PersistanceController.shared.getPicture(Key: path)
        self.navigationController?.pushViewController(resultVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var imageThumb: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
}
