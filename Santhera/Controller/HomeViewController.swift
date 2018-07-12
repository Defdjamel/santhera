//
//  ViewController.swift
//  Santhera
//
//  Created by Farin Louis on 31/05/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let homePatientRecentCellId = "HomePatientRecentCell"
    private let homeBotCellId = "HomeBotCell"
    private let homeAccuityCellId = "HomeAccuityCell"
    
    override func viewDidLoad() {
        self.tableView.register(UINib.init(nibName: homePatientRecentCellId, bundle: Bundle.main), forCellReuseIdentifier: homePatientRecentCellId)
        self.tableView.register(UINib.init(nibName: homeBotCellId, bundle: Bundle.main), forCellReuseIdentifier: homeBotCellId)
        self.tableView.register(UINib.init(nibName: homeAccuityCellId, bundle: Bundle.main), forCellReuseIdentifier: homeAccuityCellId)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        setNavLogo()
        
    }
    
    func setNavLogo(){
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.barTintColor = UIColor.white
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        imageView.image = #imageLiteral(resourceName: "logo_navbar")
        navigationItem.titleView = imageView
        
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: homePatientRecentCellId, for: indexPath) as! HomePatientRecentCell
            // Configure the cell...
            cell.patients = DataManager.sharedInstance.getRecentPatients()
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: homeBotCellId, for: indexPath) as! HomeBotCell
            // Configure the cell...
             return cell
        }
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: homeAccuityCellId, for: indexPath) as! HomeAccuityCell
            // Configure the cell...
            return cell
        }
        
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
             return HomePatientRecentCell.getHeight()
        case 1:
            return HomeBotCell.getHeight()
        case 2:
            return HomeAccuityCell.getHeight()
        default:
             return 0
        }
       
    }
}
