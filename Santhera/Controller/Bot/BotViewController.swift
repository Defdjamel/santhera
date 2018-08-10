//
//  BotViewController.swift
//  Santhera
//
//  Created by james on 09/08/2018.
//  Copyright © 2018 Wopata. All rights reserved.
//

import UIKit

private let BotMessageCellId = "BotMessageCell"


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
        selectorChoices.delegate = self
        displaySelectorView(value:false)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        startBot()
      
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
        botNodes.append(node)
       
        let indexPath = IndexPath.init(row: botNodes.count - 1 , section: 0 )
        tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.left)
        tableView.scrollToBottom()
        
        
        if node.type == NodeType.question.rawValue {
              displaySelectorView(value: true)
            let choices = BotNodeManager.sharedInstance.getNodeWithParentKey(key: node.key)
            self.selectorChoices.setChoices(choices: choices)
          
        }else {
            displaySelectorView(value: false)
        }
        goToNextNode()
       
    }
    private func goToNextNode(){
        guard  let node  = botNodes.last else {
         return
        }
         let goToKey = node.goto
        if goToKey.isEmpty{
            print("goToKey empty!💣")
            return
        }
        addNodeWithKey(key: goToKey)
    }
    private func displaySelectorView(value: Bool){
       
        heightSelectorChoice.constant = value ? 90 : 0
        selectorChoices.layoutIfNeeded()
        selectorChoices.needsUpdateConstraints()
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
        if node.type == NodeType.message.rawValue || node.type == NodeType.question.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: BotMessageCellId, for: indexPath) as! BotMessageCell
            // Configure the cell...
            cell.setNodeBot(botNode: node)
            return cell
        }
       
        return UITableViewCell.init()
    }
    
    
}

//MARK: - BotChoicesSelectorViewDelegate
extension BotViewController: BotChoicesSelectorViewDelegate {
    func BotChoicesSelectorView(_ botChoicesSelectorView: BotChoicesSelectorView, DidSelect botNode: BotNode) {
         addNodeWithKey(key: botNode.goto)
    }
    
    
}
