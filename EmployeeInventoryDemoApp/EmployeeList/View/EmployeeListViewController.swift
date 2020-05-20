//
//  EmployeeListViewController.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {
    @IBOutlet weak var employeeListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let list = EmployeeListModel()
        list.employeeID = "604445"
        list.employeeBand = "U3"
        list.employeeCompetency = "Mobility"
        list.employeeCurrentProject = "ATT FirstNet"
        list.employeeDesignation = "Senior Software Engineer"
        list.employeeName = "Sachin Amreshwar Randive"
        DatabaseManager.sharedInstance.addData(object: list)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        employeeListTableView.reloadData()
        print(1)
    }
    //MARK:- Add New Employee Record
    @IBAction func AddNewEmployeeRecordAction(_ sender: Any) {
        let nav = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddNewEmployee") as! NewEmployeeViewController
        // nav.addDelegate = self
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension EmployeeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DatabaseManager.sharedInstance.getDataFromDB().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: EEConstants.cellIdentifier) as! EmployeeTableCell
        let index = Int(indexPath.row)
        let listOfEmployee = DatabaseManager.sharedInstance.getDataFromDB()[index] as EmployeeListModel
        cell.labelEmployeeID.text = listOfEmployee.employeeID
        cell.labelName.text = listOfEmployee.employeeName + " (\(listOfEmployee.employeeBand))"
        cell.labelProject.text = "Project: " + listOfEmployee.employeeCurrentProject
        cell.labelCompetency.text = "Competency: " + listOfEmployee.employeeCompetency
        cell.labelDesignation.text = listOfEmployee.employeeDesignation
        cell.profileImage.image = UIImage(named: "iPhone")
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
        
        //        if( indexPath.row > -1) {
        //
        //            let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondView") as! secondViewController
        //
        //            let index = Int(indexPath.row)
        //            let item = DBManager.sharedInstance.getDataFromDB()[index] as Item
        //
        //            vc.currentItem = item
        //            self.present(vc, animated: true, completion: nil)
        //        }
    }
}
