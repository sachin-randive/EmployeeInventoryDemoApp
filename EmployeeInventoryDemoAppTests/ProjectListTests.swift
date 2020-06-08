//
//  ProjectListTests.swift
//  EmployeeInventoryDemoAppTests
//
//  Created by Sachin Randive on 08/06/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import XCTest
@testable import EmployeeInventoryDemoApp

class ProjectListTests: XCTestCase {
    
    var projectListViewController: ProjectListViewController!
    var projectListViewModel = ProjectListViewModel()
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.projectListViewController = storyboard.instantiateViewController(withIdentifier: "projectList") as? ProjectListViewController
        self.projectListViewController.loadView()
        self.projectListViewController.viewDidLoad()
        if DatabaseManager.sharedInstance.getProjectNameArray().count < 1 {
            DatabaseManager.sharedInstance.saveProjectListArray()
        }
        projectListViewModel.getProjectList()
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
    
    func testProjectListNotNil() {
        let projectList = projectListViewModel.projectList[0]
        XCTAssertNotNil(projectList)
        XCTAssertEqual(projectList.projectName, "ATT FirstNet")
    }
    
    func testCheckIfAllCurrentProjectNameNotNil() {
        for projectName in projectListViewModel.projectList {
            XCTAssertNotNil(projectName.projectName)
        }
    }
    
    override func tearDown() {
      projectListViewModel.projectList = []
    }
    
}
