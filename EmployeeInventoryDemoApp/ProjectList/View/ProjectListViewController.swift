//
//  ProjectListViewController.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectListViewController: UIViewController {
    
    @IBOutlet weak var projectListTableView: UITableView!
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradientBackground(gradientLayer:gradientLayer)
    }
    
    @IBAction func addNewProjectAction(_ sender: Any) {
        let ac = UIAlertController(title: "Enter new Project", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let projectName = ac.textFields![0]
            if projectName.text != "" {
                let projectListModel = ProjectListModel()
                projectListModel.projectName = projectName.text!
                DatabaseManager.sharedInstance.addProject(object: projectListModel)
                self.projectListTableView.reloadData()
            }
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
}

extension ProjectListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatabaseManager.sharedInstance.getProjectNameArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: EEConstants.projectListCellIdentifier) as UITableViewCell?
        if (cell == nil) {
            cell =  UITableViewCell(style:.default, reuseIdentifier: "CELL")
        }
        cell?.textLabel?.textColor = UIColor.white
        let index = Int(indexPath.row)
        let listOfEmployee = DatabaseManager.sharedInstance.getProjectNameArray()[index] as ProjectListModel
        cell?.textLabel?.text = listOfEmployee.projectName
        cell?.selectionStyle = .none
        cell?.backgroundColor = .clear
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = DatabaseManager.sharedInstance.getProjectNameArray()[indexPath.row]
            var database:Realm
            database = try! Realm()
            try! database.write {
                database.delete(item)
            }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

