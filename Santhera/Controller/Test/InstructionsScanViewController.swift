//
//  InstructionsScanViewController.swift
//  Santhera
//
//  Created by james on 06/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
private let instructionCellId = "InstructionStepCell"


struct InstructionStep {
     public var title: String
     public var subtitle: String
     public var imageName: String
   
}
class InstructionsScanViewController: UIViewController {
    var stepItems : Array<InstructionStep> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
   // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: instructionCellId, bundle: Bundle.main), forCellReuseIdentifier: instructionCellId)
        for index in 1...5 {
            let step =  InstructionStep.init(title: L("step_title_\(index)"), subtitle: L("step_subtitle_\(index)"), imageName: "icEtape\(index)")
            stepItems.append(step)
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - IBAction

    @IBAction func onClickDownload(_ sender: Any) {
        shareFile()
    }
    
    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Private Methods
    private func shareFile(){
        let url = NSURL.fileURL(withPath:  Bundle.main.path(forResource: "Grille_Goldmann", ofType: "pdf")!)
        let objectsToShare = [url]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - UITableViewDataSource
extension InstructionsScanViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: instructionCellId, for: indexPath) as! InstructionStepCell
            cell.setStep(step: stepItems[indexPath.row])
            return cell
     
    }
    
    
}
