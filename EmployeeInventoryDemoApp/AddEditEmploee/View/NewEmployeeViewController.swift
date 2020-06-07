//
//  NewEmployeeViewController.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit
import RealmSwift

protocol NewEmployeeViewControllerProtocal {
    func didGoBackAndReloadTableData()
}

class NewEmployeeViewController: UIViewController {
    //MARK: - Outlets
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
    var addEmployeeDelegate: NewEmployeeViewControllerProtocal?
    
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
    
    //  Edit Action
    @IBAction func editDetailsAction(_ sender: Any) {
        isUserInterActionEnabled()
        self.navigationItem.rightBarButtonItem = nil
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
        txtEmployeeID.isUserInteractionEnabled = false
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
            self.txtProjectName.becomeFirstResponder()
        })
    }
    
    func validate() {
        do {
            let list = EmployeeListModel()
            list.employeeName = try txtEmployeeName.validatedText(validationType: ValidatorType.employeeName)
            list.employeeBand = try txtEmployeeBand.validatedText(validationType: ValidatorType.employeeBand)
            list.employeeDesignation = try txtEmployeeDesignation.validatedText(validationType: ValidatorType.employeeDesignation)
            list.employeeCompetency = try txtCompetency.validatedText(validationType: ValidatorType.employeeCompetency)
            list.employeeCurrentProject = try txtProjectName.validatedText(validationType: ValidatorType.employeeCurrentProject)
            
            if isEditDeatils == false {
                let empID = newEmployeeViewModel.fourDigitID
                list.employeeID = empID
                DatabaseManager.sharedInstance.addData(object: list)
            } else {
                list.employeeID = txtEmployeeID.text ?? ""
                var database:Realm
                database = try! Realm()
                try! database.write {
                    database.add(list, update: .modified)
                }
            }
            
            self.popupAlert(title: EEConstants.success, message:EEConstants.sucessMessage, actionTitles: ["OK"], actions:[{action1 in
                DispatchQueue.main.async {
                    self.addEmployeeDelegate?.didGoBackAndReloadTableData()
                    self.navigationController?.popViewController(animated: true)
                } }, nil])
            
        } catch(let error) {
            alert(message: (error as! ValidationError).message, title: "")
        }
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        validate()
    }
}

// MARK: - TextField Delegate
extension NewEmployeeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // textField delegate method start from here
        if textField == txtEmployeeBand {
            let maxLength:Int = 2
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DispatchQueue.main.async {
            textField.text = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        textField.resignFirstResponder()
        return true
    }
}

