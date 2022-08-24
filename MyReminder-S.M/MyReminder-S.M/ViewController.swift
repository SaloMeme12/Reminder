//
//  ViewController.swift
//  MyReminder-S.M
//
//  Created by Mcbook Pro on 23.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var documents = [String]()
    let filemeneger = FileManagersActions()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.dataSource = self
        tableview.delegate = self
    
         fetch()
        
    }
    
    private func fetch(){
        filemeneger.fetchDataFromFM { [weak self] allFolders in
            self?.documents = allFolders
            
            tableview.reloadData()        }
    }

   // MARK: - alert
    private func showAlert(){
        let alert = UIAlertController(
            title: "Create Checklists",
            message: "",
            preferredStyle: .alert)
        
        //add fields
        alert.addTextField { textFiled in
            textFiled.placeholder =  "Name of checklist"
        }
        
        
        // add button
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            //read texfileds value
            guard let fields = alert.textFields else {return}
            let userInput = fields[0]
            
            guard let text = userInput.text else {return}
            
            
            // create Directory in filemanager
            self.filemeneger.saveToFileManager(textFromTexfield: text)
            
            self.documents.append(text)
            self.tableview.reloadData()
            
        }))
        present(alert, animated: true)
        
    }
    
    @IBAction func addcheckListTapped(_ sender: Any) {
        
        showAlert()
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let model = documents[indexPath.row]
        cell.textLabel?.text = model
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dirName = documents[indexPath.row]
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "TodoViewController") as! TodoViewController
        
        VC.dirName = dirName
        
        navigationController?.pushViewController(VC, animated: true)
    }
}
