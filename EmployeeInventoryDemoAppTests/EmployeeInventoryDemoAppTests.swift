//
//  EmployeeInventoryDemoAppTests.swift
//  EmployeeInventoryDemoAppTests
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import XCTest
@testable import EmployeeInventoryDemoApp

class EmployeeInventoryDemoAppTests: XCTestCase {
    
    var projectListViewController: ProjectListViewController!
    var employeeListViewModel = EmployeeListViewModel()
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.projectListViewController = storyboard.instantiateViewController(withIdentifier: "projectList") as? ProjectListViewController
        self.projectListViewController.loadView()
        self.projectListViewController.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasATableView() {
        XCTAssertNotNil(projectListViewController.projectListTableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(projectListViewController.projectListTableView.delegate)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(projectListViewController.projectListTableView.dataSource)
    }
    
    func testViewModelInitialProperties() {
        XCTAssertEqual(employeeListViewModel.employeeList, [])
        XCTAssertEqual(employeeListViewModel.filteredEmployeeList, [])
    }
    
    func testEmployeeViewModelCheckFilterdAndEmployeeArrayIsEqual() {
        let filteredArray = employeeListViewModel.filteredEmployeeList.count
        let employeeArray = employeeListViewModel.employeeList.count
        XCTAssertEqual(employeeArray, filteredArray)
    }
    
    func testEmployeeDataNotNil() {
          employeeListViewModel.getEmployeeList()
          let employee = employeeListViewModel.filteredEmployeeList[0]
          XCTAssertNotNil(employee)
          XCTAssertEqual(employee.employeeID, "0351")
          XCTAssertEqual(employee.employeeBand, "U3")
          XCTAssertEqual(employee.employeeCompetency, "UX")
          XCTAssertEqual(employee.employeeCurrentProject, "Resource Management App")
      }
}
