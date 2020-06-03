//
//  NewEmployeeViewController.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class NewEmployeeViewController: UIViewController {
    
    @IBOutlet weak var txtEmployeeID: UITextField!
    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtEmployeeBand: UITextField!
    @IBOutlet weak var txtEmployeeDesignation: UITextField!
    @IBOutlet weak var txtCompetency: UITextField!
    @IBOutlet weak var txtProjectName: UITextField!
    @IBOutlet weak var btnCompetency: UIButton!
    @IBOutlet weak var btnCurrentProject: UIButton!
    @IBOutlet weak var commanStackView: UIStackView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var selectedButton = UIButton()
    var commanArray = [String]()
    var isEditDeatils: Bool?
    
    fileprivate var newEmployeeViewModel = NewEmployeeViewModel()
    let gradientLayer = CAGradientLayer()
    var selectedEmployeeArray: EmployeeListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradientBackground(gradientLayer:gradientLayer)
        saveButton.layer.cornerRadius = 5
        if isEditDeatils == true {
        print(selectedEmployeeArray as Any)
            txtEmployeeID.text = selectedEmployeeArray?.employeeID
            txtEmployeeName.text = selectedEmployeeArray?.employeeName
            txtEmployeeBand.text = selectedEmployeeArray?.employeeBand
            txtEmployeeDesignation.text = selectedEmployeeArray?.employeeDesignation
            txtCompetency.text = selectedEmployeeArray?.employeeCompetency
            txtProjectName.text = selectedEmployeeArray?.employeeCurrentProject
            saveButton.isHidden = true
            navigationItem.title = "Employee Details"
            self.navigationItem.rightBarButtonItem = self.editButton
            isUserInterActionDisabled()
        } else {
           self.navigationItem.rightBarButtonItem = nil
           saveButton.isHidden = false
        }
    }
    
    @IBAction func editDetailsAction(_ sender: Any) {
        isUserInterActionEnabled()
        saveButton.isHidden = false
        navigationItem.title = "Edit Details"
    }
    
    func isUserInterActionDisabled() {
        txtEmployeeID.isUserInteractionEnabled = false
        txtEmployeeName.isUserInteractionEnabled = false
        txtEmployeeBand.isUserInteractionEnabled = false
        txtEmployeeDesignation.isUserInteractionEnabled = false
        btnCompetency.isUserInteractionEnabled = false
        btnCurrentProject.isUserInteractionEnabled = false
        txtCompetency.isUserInteractionEnabled = false
        txtProjectName.isUserInteractionEnabled = false
    }
    func isUserInterActionEnabled() {
        txtEmployeeID.isUserInteractionEnabled = true
        txtEmployeeName.isUserInteractionEnabled = true
        txtEmployeeBand.isUserInteractionEnabled = true
        txtEmployeeDesignation.isUserInteractionEnabled = true
        btnCompetency.isUserInteractionEnabled = true
        btnCurrentProject.isUserInteractionEnabled = true
        txtCompetency.isUserInteractionEnabled = true
        txtProjectName.isUserInteractionEnabled = true
        saveButton.isHidden = false
    }
    
    // MARK:- Get Competency List
    @IBAction func getCompetencyListAction(_ sender: Any) {
        commanArray = ["Android", "iOS", "UX", "Tester"]
        newEmployeeViewModel.getPickerList(array: commanArray, theameName: "Competency", completion: { result in
            self.txtCompetency.text = result
        })
    }
    
     // MARK:- Get Project List
    @IBAction func getProjectListAction(_ sender: Any) {
        commanArray.removeAll()
        for item in DatabaseManager.sharedInstance.getProjectNameArray()  {
            commanArray.append(item.projectName)
        }
        newEmployeeViewModel.getPickerList(array: commanArray, theameName: "Project Name", completion: { result in
            self.txtProjectName.text = result
        })
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        let empID = newEmployeeViewModel.fourDigitID
        let list = EmployeeListModel()
        list.employeeID = empID
        list.employeeBand = txtEmployeeBand.text ?? ""
        list.employeeCompetency = txtCompetency.text ?? ""
        list.employeeCurrentProject = txtProjectName.text ?? ""
        list.employeeDesignation = txtEmployeeDesignation.text ?? ""
        list.employeeName = txtEmployeeName.text ?? ""
        DatabaseManager.sharedInstance.addData(object: list)
    }
}
