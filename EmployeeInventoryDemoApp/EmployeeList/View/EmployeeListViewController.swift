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
    fileprivate let employeeListViewModel = EmployeeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if DatabaseManager.sharedInstance.getProjectNameArray().count < 1 {
            DatabaseManager.sharedInstance.saveProjectListArray()
        }
        self.setGradientBackground(gradientLayer:gradientLayer)
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.darkGray
        employeeListViewModel.delegate = self
        employeeListViewModel.getEmployeeList()
        employeeListTableView.accessibilityIdentifier = EEConstants.tableEmployeeTableView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.text = ""
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        DispatchQueue.main.async {
            self.searchBar.resignFirstResponder()
        }
    }
    
    //MARK:- Add New Employee Record
    @IBAction func AddNewEmployeeRecordAction(_ sender: Any) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployee") as! NewEmployeeViewController
        nav.hidesBottomBarWhenPushed = true
        nav.isEditDeatils = false
        nav.addEmployeeDelegate = self
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListViewModel.filteredEmployeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: EEConstants.EmployeeListcellIdentifier) as! EmployeeTableCell
        print(employeeListViewModel.filteredEmployeeList[indexPath.row])
        let listOfEmployee = employeeListViewModel.filteredEmployeeList[indexPath.row]
        cell.accessibilityIdentifier = "myCell_\(indexPath.row)"
        cell.labelEmployeeID.text = listOfEmployee.employeeID
        cell.labelName.text = listOfEmployee.employeeName + " (\(listOfEmployee.employeeBand))"
        cell.labelProject.text = "Project: " + listOfEmployee.employeeCurrentProject
        cell.labelCompetency.text = "Competency: " + listOfEmployee.employeeCompetency
        cell.labelDesignation.text = listOfEmployee.employeeDesignation
        if (UIImage(named:"\(listOfEmployee.employeeCompetency)") != nil) {
            cell.profileImage.image = UIImage(named: "\(listOfEmployee.employeeCompetency)")
        }
        else {
            cell.profileImage.image = UIImage(named: "default")
        }
        
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
        nav.selectedEmployeeArray = employeeListViewModel.filteredEmployeeList[indexPath.row]
        nav.isEditDeatils = true
        nav.addEmployeeDelegate = self
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = employeeListViewModel.filteredEmployeeList[indexPath.row]
            var database:Realm
            database = try! Realm()
            try! database.write {
                database.delete(item)
            }
            employeeListViewModel.getEmployeeList()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

//MARK: - UISearchBar Delegate
extension EmployeeListViewController: UISearchBarDelegate {
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        employeeListViewModel.searchEmployee(with: searchText) {
            self.employeeListTableView.reloadData()
            if searchText.isEmpty {
                self.dismissKeyboard()
            }
        }
    }
}

// MARK: - Delegate Methods of EmployeeListViewModelProtocal
extension EmployeeListViewController: EmployeeListViewModelProtocal {
    
    func didUpdateEmployeeInfo() {
        employeeListTableView.reloadData()
    }
}

// MARK: - Delegate Methods of NewEmployeeViewControllerProtocal
extension EmployeeListViewController: NewEmployeeViewControllerProtocal {
    
    func didGoBackAndReloadTableData() {
        employeeListViewModel.getEmployeeList()
    }
}

