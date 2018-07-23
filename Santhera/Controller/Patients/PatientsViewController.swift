//
//  PatientsViewController.swift
//  Santhera
//
//  Created by james on 17/07/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
private var HomePatientCollectionViewCellId = "HomePatientCollectionViewCell"
private let heightPatientCell = 150.0

class PatientsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var patients : Array<Patient> = []
    var patientsFilter : Array<Patient> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addKeyboardObs()
       
    }
    func configure(){
        self.title = L("patients_title")
        self.searchBar.placeholder = L("patients_searchBar_placeholder")
        patients = PatientManager.sharedInstance.getAllPatients()
        // Do any additional setup after loading the view.
        self.collectionView.register(UINib.init(nibName: HomePatientCollectionViewCellId , bundle: Bundle.main), forCellWithReuseIdentifier: HomePatientCollectionViewCellId )
    }
    func addKeyboardObs(){
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetFilter(){
        patients = PatientManager.sharedInstance.getAllPatients()
        self.collectionView.reloadData()
    }
    func filterByText(text: String){
        patients = PatientManager.sharedInstance.getAllPatientsFilterText(text: text)
        self.collectionView.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? PaitentDetailsViewController {
            if let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
               vc.currentPatient = patients[indexPath.row]
            }
        }
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PatientsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: heightPatientCell, height: heightPatientCell)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0 , left: 20.0 , bottom: 20.0, right: 20.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK: - UICollectionViewDelegate
extension PatientsViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "patientDetails", sender: self)
    }
}

//MARK: - UICollectionViewDataSource
extension PatientsViewController: UICollectionViewDataSource{
   
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
}

//MARK: - UISearchBarDelegate
extension PatientsViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count > 0 {
            self.filterByText(text: searchBar.text!)
        }
        else {
            self.resetFilter()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
//MARK: - Keyboard
extension PatientsViewController {
    
    @objc open func keyboardWillShow(_ notification: Foundation.Notification) {
        if let rectValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let kbRect = view.convert(rectValue.cgRectValue, from: nil)
            bottomConstraint.constant = kbRect.size.height
        }
    }
    @objc open func keyboardWillHide(_ notification: Foundation.Notification) {
        bottomConstraint.constant = 0
    }
    
}
