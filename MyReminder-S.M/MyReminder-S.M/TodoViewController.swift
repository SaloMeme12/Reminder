//
//  TodoViewController.swift
//  MyReminder-S.M
//
//  Created by Mcbook Pro on 23.08.22.
//

import UIKit

class TodoViewController: UIViewController {
    
    var dirName = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    let filemeneger = FileManagersActions()
    //data model
    
    var model = [String]()
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //save data in FM
        
        
        tableView.delegate = self
        tableView.dataSource = self
      
    }
    
    //retrive data from FM and populate model
    
    private func fetchingTextDoc(){
        
    }
    
    // add todo with alert
    private func showAlert(){
        let alert = UIAlertController(
            title: "Create Task",
            message: "",
            preferredStyle: .alert)
        
        //add fields
        alert.addTextField { textFiled in
            textFiled.placeholder =  "add task "
        }
        
        
        // add button
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            
            //read texfileds value
            guard let fields = alert.textFields else {return}
            let userInput = fields[0]
            
            guard let text = userInput.text else {return}
            
            
             //create File
            self?.filemeneger.writeFile(titleOfTextFile: text, tapedDir: self!.dirName)

            self?.model.append(text)
            self?.tableView.reloadData()
            
        }))
        present(alert, animated: true)
        
    }
    
    @IBAction func addTaskTapped(_ sender: Any) {
        showAlert()
    }
}

extension TodoViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        cell.textLabel?.text = model[indexPath.row]
        return cell
    }
    
    
}
