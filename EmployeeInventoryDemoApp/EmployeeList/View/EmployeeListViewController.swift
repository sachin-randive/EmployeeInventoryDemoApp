//
//  EmployeeListViewController.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit
import RealmSwift

class EmployeeListViewController: UIViewController {
    
    @IBOutlet weak var employeeListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DatabaseManager.sharedInstance.getProjectNameArray().count < 1 {
        DatabaseManager.sharedInstance.saveProjectListArray()
        }
        self.setGradientBackground(gradientLayer:gradientLayer)
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.darkGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        employeeListTableView.reloadData()
    }
    
    //MARK:- Add New Employee Record
    @IBAction func AddNewEmployeeRecordAction(_ sender: Any) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployee") as! NewEmployeeViewController
        nav.hidesBottomBarWhenPushed = true
        nav.isEditDeatils = false
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatabaseManager.sharedInstance.getDataFromDB().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: EEConstants.EmployeeListcellIdentifier) as! EmployeeTableCell
        let index = Int(indexPath.row)
        let listOfEmployee = DatabaseManager.sharedInstance.getDataFromDB()[index] as EmployeeListModel
        cell.labelEmployeeID.text = listOfEmployee.employeeID
        cell.labelName.text = listOfEmployee.employeeName + " (\(listOfEmployee.employeeBand))"
        cell.labelProject.text = "Project: " + listOfEmployee.employeeCurrentProject
        cell.labelCompetency.text = "Competency: " + listOfEmployee.employeeCompetency
        cell.labelDesignation.text = listOfEmployee.employeeDesignation
        cell.profileImage.image = UIImage(named: "\(listOfEmployee.employeeCompetency)")
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployee") as! NewEmployeeViewController
        nav.hidesBottomBarWhenPushed = true
        nav.selectedEmployeeArray = DatabaseManager.sharedInstance.getDataFromDB()[indexPath.row]
        nav.isEditDeatils = true
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = DatabaseManager.sharedInstance.getDataFromDB()[indexPath.row]
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
