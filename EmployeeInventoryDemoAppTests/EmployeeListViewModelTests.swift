//
//  EmployeeListViewModelTests.swift
//  EmployeeInventoryDemoAppTests
//
//  Created by Sachin Randive on 07/06/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import XCTest
@testable import EmployeeInventoryDemoApp

class EmployeeListViewModelTests: XCTestCase {
    
    var employeeListViewModel = EmployeeListViewModel()
    
    override func setUp() {
        let employeeListModel = EmployeeListModel(ID:"0235", name: "Ani  Roi", band: "P1", designation: "Lead Associate", competency: "iOS", project: "ATT")
        let jsonEncoder = JSONEncoder()
        let json = try! jsonEncoder.encode(employeeListModel)
        let results = try! JSONDecoder().decode(EmployeeListModel.self, from: json)
        employeeListViewModel.employeeList = [results]
        employeeListViewModel.filteredEmployeeList = [results]
    }
    
    override func tearDown() {
        employeeListViewModel.employeeList = []
        employeeListViewModel.filteredEmployeeList = []
    }
    
    func testEmployeeViewModelCheckFilterdAndEmployeeArrayIsEqual() {
        let filteredArray = employeeListViewModel.filteredEmployeeList.count
        let employeeArray = employeeListViewModel.employeeList.count
        XCTAssertEqual(employeeArray, filteredArray)
    }
    
    func testEmployeeInfoNotNil() {
        let employee = employeeListViewModel.filteredEmployeeList[0]
        XCTAssertNotNil(employee)
        XCTAssertEqual(employee.employeeID, "0235")
        XCTAssertEqual(employee.employeeName, "Ani  Roi")
        XCTAssertEqual(employee.employeeBand, "P1")
        XCTAssertEqual(employee.employeeDesignation, "Lead Associate")
        XCTAssertEqual(employee.employeeCompetency, "iOS")
        XCTAssertEqual(employee.employeeCurrentProject, "ATT")
    }
    
    func testEmployeeInfoNil() {
        let employee = employeeListViewModel.filteredEmployeeList[0]
        XCTAssertNotEqual(employee.employeeID, "")
        XCTAssertNotEqual(employee.employeeName, "")
        XCTAssertNotEqual(employee.employeeBand, "")
        XCTAssertNotEqual(employee.employeeDesignation, "")
        XCTAssertNotEqual(employee.employeeCompetency, "")
        XCTAssertNotEqual(employee.employeeCurrentProject, "")
    }
    
    func testCheckIfAllEmployeesNameNotNil() {
        for employee in employeeListViewModel.filteredEmployeeList {
            XCTAssertNotNil(employee.employeeName)
        }
    }
    
    func testEmployeeCompleteSearchResult() {
        employeeListViewModel.searchEmployee(with: "Ani") {
            XCTAssertEqual(self.employeeListViewModel.filteredEmployeeList.count, 1)
        }
        let employee = employeeListViewModel.filteredEmployeeList[0]
        XCTAssertEqual(employee.employeeID, "0235")
        XCTAssertEqual(employee.employeeName, "Ani  Roi")
        XCTAssertEqual(employee.employeeBand, "P1")
        XCTAssertEqual(employee.employeeDesignation, "Lead Associate")
        XCTAssertEqual(employee.employeeCompetency, "iOS")
        XCTAssertEqual(employee.employeeCurrentProject, "ATT")
    }
}
