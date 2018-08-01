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
private let heightBtnSave : CGFloat = 60

protocol PatientsViewControllerDelegate {
    func patientsViewController(_ patientsViewController: PatientsViewController, DidSelect patient: Patient)
}

class PatientsViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightBtnSaveConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSaveContainer: UIView!
    @IBOutlet weak var btnSave: buttonValidate!
    
    var patients : Array<Patient> = []
    var patientsFilter : Array<Patient> = []
    var isPatientSelectable = false
    var patientsSelected : Array<Patient> = []
    var delegate : PatientsViewControllerDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addKeyboardObs()
        updateBtnSave()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        if searchBar.text?.count > 0 {
            self.filterByText(text: searchBar.text!)
        }
        else{
            resetFilter()
        }
    }
    
    // MARK: - Private method
    private func configure(){
        self.title = L("patients_title")
        self.searchBar.placeholder = L("patients_searchBar_placeholder")
        patients = PatientManager.sharedInstance.getAllPatients()
        self.collectionView.register(UINib.init(nibName: HomePatientCollectionViewCellId , bundle: Bundle.main), forCellWithReuseIdentifier: HomePatientCollectionViewCellId )
        addRightButton()
       
        btnSave.isHidden = !isPatientSelectable
        heightBtnSaveConstraint.constant = isPatientSelectable ? heightBtnSave : 0
    }
    private func addRightButton(){
        let  menu_button_ = UIBarButtonItem(image: #imageLiteral(resourceName: "icAddPatient"),
                                            style: UIBarButtonItemStyle.plain ,
                                            target: self, action:  #selector(OnNewPatientClicked) )
        menu_button_.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem =  menu_button_
    }
    private func isPatientSelected(patient: Patient) -> Bool{
        return  patientsSelected.contains(patient) ? true : false
    }
    private func selectPatient(patient: Patient){
        patientsSelected.removeAll()
        patientsSelected.append(patient)
        self.collectionView.reloadData()
        updateBtnSave()
    }
    private func addKeyboardObs(){
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SHKeyboardViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    private func updateBtnSave(){
        btnSave.isEnabled =  patientsSelected.count > 0  ? true : false
    }
    
    private func resetFilter(){
        patients = PatientManager.sharedInstance.getAllPatients()
        self.collectionView.reloadData()
    }
    private func filterByText(text: String){
        patients = PatientManager.sharedInstance.getAllPatientsFilterText(text: text)
        self.collectionView.reloadData()
    }
   
    
    // MARK: - IBAction
    @objc func OnNewPatientClicked(){
        self.performSegue(withIdentifier: "newPatient", sender: self)
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        if patientsSelected.count > 0 , let patient = patientsSelected.first {
            self.delegate?.patientsViewController(self, DidSelect: patient)
        }
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
        if isPatientSelectable {
            selectPatient(patient: patients[indexPath.row])
        }else {
             self.performSegue(withIdentifier: "patientDetails", sender: self)
        }
       
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
        let patient = patients[indexPath.row]
        cell.setObj(obj: patient )
        
        if isPatientSelectable{
            cell.setPatientSelected(value: self.isPatientSelected(patient: patient))
        }
        
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
