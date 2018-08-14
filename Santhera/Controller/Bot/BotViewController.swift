//
//  BotViewController.swift
//  Santhera
//
//  Created by james on 09/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit
import AppImageViewer
import PDFKit

private let BotMessageCellId = "BotMessageCell"
private let BotSelectionCellId = "BotSelectionCell"
private let BotDocumentCellId = "BotDocumentCell"


private let firstKeyBot = "welcome_bot"
private let insertMessageDelay = 0.6

class BotViewController: UIViewController {
    @IBOutlet weak var heightSelectorChoice: NSLayoutConstraint!
    @IBOutlet weak var selectorChoices: BotChoicesSelectorView!
    @IBOutlet weak var tableView: UITableView!
    var botNodes :  Array<BotNode> = []
    
    //MARK: lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        BotNodeManager.sharedInstance.updateBotFromJsonFile()
        self.tableView.register(UINib.init(nibName: BotMessageCellId, bundle: Bundle.main), forCellReuseIdentifier: BotMessageCellId)
        self.tableView.register(UINib.init(nibName: BotSelectionCellId, bundle: Bundle.main), forCellReuseIdentifier: BotSelectionCellId)
        self.tableView.register(UINib.init(nibName: BotDocumentCellId, bundle: Bundle.main), forCellReuseIdentifier: BotDocumentCellId)
        selectorChoices.delegate = self
        displaySelectorView(value:false)
         startBot()
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: false)
      
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    private func startBot(){
        botNodes.removeAll()
        addNodeWithKey(key: firstKeyBot)
        
    }
    private func addNodeWithKey(key: String){
        guard let node =  BotNodeManager.sharedInstance.getNodeWithKey(key: key) else{
            print("node not found with key:")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + insertMessageDelay) { // change 2 to desired number of seconds
            self.addNode(node: node)
        }
        
    }
    private func addNode(node: BotNode){
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            print("end anim")
            self.tableView.reloadData()
        })
        tableView.beginUpdates()
        botNodes.append(node)
        let indexPath = IndexPath.init(row: botNodes.count - 1 , section: 0 )
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.left)
        tableView.scrollToBottom()
        tableView.endUpdates()
        CATransaction.commit()
        
        updateSelectorView()
        goToNextNode()
    }
    private func goToNextNode(){
        guard  let node  = botNodes.last else {
         return
        }
         let goToKey = node.goto
        if goToKey.isEmpty{
            print("goToKey empty!💣",node.key)
            return
        }
        addNodeWithKey(key: goToKey)
    }
    private func updateSelectorView(){
        guard let node = botNodes.last else {
            return
        }
        if node.type == NodeType.question.rawValue {
        displaySelectorView(value: true)
        let choices = BotNodeManager.sharedInstance.getNodeWithParentKey(key: node.key)
        self.selectorChoices.setChoices(choices: choices)
    
        }else {
        displaySelectorView(value: false)
        }
    }
    private func displaySelectorView(value: Bool){
       
        heightSelectorChoice.constant = value ? 90 : 0
        selectorChoices.layoutIfNeeded()
        selectorChoices.needsUpdateConstraints()
    }
    private func isLastNodeQuesionSelection(node: BotNode) -> Bool{
        var isLast = false
        for item in botNodes {
             if item.type == NodeType.questionChoice.rawValue {
                if item == node {
                    isLast = true
                }else {
                      isLast = false
                }
            }
        }
        return isLast
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - UITableViewDelegate
extension BotViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let node =  botNodes[indexPath.row]
        if node.type == NodeType.questionChoice.rawValue {
            // remove all row after indexPath
            botNodes.removeLast( botNodes.count -  indexPath.row)
            self.tableView.reloadData()
             updateSelectorView()
            
        }
        if node.type == NodeType.document.rawValue {
            if  let document = DocumentManager.sharedInstance.getDocumentWithName(key: node.arg) {
                
                if document.type == DocumentType.pdf.rawValue {
                    openPDF(document: document)
                }
                else  if document.type == DocumentType.image.rawValue {
                    guard let cell = self.tableView.cellForRow(at: indexPath) else{
                        return
                    }
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
        }
        
    }
}
//MARK: - UITableViewDataSource
extension BotViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return botNodes.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let node =  botNodes[indexPath.row]
        if node.type == NodeType.message.rawValue || node.type == NodeType.question.rawValue || node.type == NodeType.stop.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: BotMessageCellId, for: indexPath) as! BotMessageCell
            // Configure the cell...
            cell.setNodeBot(botNode: node)
            return cell
        }else if node.type == NodeType.questionChoice.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: BotSelectionCellId, for: indexPath) as! BotSelectionCell
             cell.setNodeBot(botNode: node)
            cell.setEditable(value: self.isLastNodeQuesionSelection(node: node))
            return cell
        }else if node.type == NodeType.document.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: BotDocumentCellId, for: indexPath) as! BotDocumentCell
            cell.setNodeBot(botNode: node)
            return cell
        }
        
        return UITableViewCell.init()
    }
    
}

//MARK: - BotChoicesSelectorViewDelegate
extension BotViewController: BotChoicesSelectorViewDelegate {
    func BotChoicesSelectorView(_ botChoicesSelectorView: BotChoicesSelectorView, DidSelect botNode: BotNode) {
        displaySelectorView(value: false)
        addNode(node: botNode)// add choice
        //addNodeWithKey(key: botNode.goto) // next node...
    }
    
    
}
