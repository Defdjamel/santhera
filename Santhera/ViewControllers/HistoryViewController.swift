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
