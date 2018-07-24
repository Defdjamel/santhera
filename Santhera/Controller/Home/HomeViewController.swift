//
//  ViewController.swift
//  Santhera
//
//  Created by Farin Louis on 31/05/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import Foundation
import UIKit
import PDFKit
import AppImageViewer
class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let homePatientRecentCellId = "HomePatientRecentCell"
    private let homeBotCellId = "HomeBotCell"
    private let homeAccuityCellId = "HomeAccuityCell"
    private let homeDocumentsCellId = "HomeDocumentsCell"
    
    override func viewDidLoad() {
        self.tableView.register(UINib.init(nibName: homePatientRecentCellId, bundle: Bundle.main), forCellReuseIdentifier: homePatientRecentCellId)
        self.tableView.register(UINib.init(nibName: homeBotCellId, bundle: Bundle.main), forCellReuseIdentifier: homeBotCellId)
        self.tableView.register(UINib.init(nibName: homeAccuityCellId, bundle: Bundle.main), forCellReuseIdentifier: homeAccuityCellId)
        self.tableView.register(UINib.init(nibName: homeDocumentsCellId, bundle: Bundle.main), forCellReuseIdentifier: homeDocumentsCellId)
        setNavLogo()
        configureNavBarBtn()
    }
  
    override func viewDidAppear(_ animated: Bool) {
       self.navigationController?.setNavigationBarHidden(false, animated: true)
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
//MARK: - UITableViewDelegate
extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
//MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
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
            cell.patients = PatientManager.sharedInstance.getRecentPatients()
            cell.delegate = self
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
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: homeDocumentsCellId, for: indexPath) as! HomeDocumentsCell
            // Configure the cell...
            cell.documents = DocumentManager.sharedInstance.getAllDocuments()
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell.init()
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return PatientManager.sharedInstance.getRecentPatients().count > 0 ? HomePatientRecentCell.getHeight() : 0
        case 1:
            return HomeBotCell.getHeight()
        case 2:
            return HomeAccuityCell.getHeight()
        case 3:
            return HomeDocumentsCell.getHeight()
        default:
             return 0
        }
    }
}
//MARK: - HomeDocumentCellDelegate
extension HomeViewController : HomeDocumentCellDelegate {
    func homeDocumentsCell(_ homeDocumentsCell: HomeDocumentsCell, DidSelectCell cell: UICollectionViewCell, document: Document) {
        if document.type == DocumentType.pdf.rawValue {
            openPDF(document: document)
        }
        else  if document.type == DocumentType.image.rawValue {
            let image =  UIImage.init(named: document.file_url)
            let appImage = ViewerImage.appImage(forImage:image!)
            let viewer = AppImageViewer(originImage: image!, photos: [appImage], animatedFromView: cell)
            viewer.isCustomShare = true
            present(viewer, animated: true, completion: nil)
        }
        else {
            showAlertDocumentInvalid()
        }
    }
    func showAlertDocumentInvalid(){
        let  popvc = PopupInfoViewController()
        popvc.showViewFromCtrl(controller: self)
        
    }
    func openPDF(document: Document) {
        let urlString = document.file_url
        let url = URL.init(fileURLWithPath: urlString)
        let pdfDocument = PDFDocument.init(url: url)
        let storyBoard : UIStoryboard = UIStoryboard(name: "PdfReader", bundle:nil)
        let pdfReaderNC = storyBoard.instantiateViewController(withIdentifier: "pdfReaderNC") as! UINavigationController
        let pdfReaderVC = pdfReaderNC.viewControllers.first as! PdfReaderViewController
        pdfReaderVC.pdfDocument = pdfDocument
        pdfReaderVC.isShareable = true
        self.navigationController?.show(pdfReaderVC, sender: self)
    }
}
//MARK: - HomePatientRecentCellDelegate
extension HomeViewController : HomePatientRecentCellDelegate {
    func HomePatientRecentCellDidSelectMore(_ homePatientRecentCell: HomePatientRecentCell) {
        self.performSegue(withIdentifier: "HomePatients", sender: self)
    }
}
