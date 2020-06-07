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
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.projectListViewController = storyboard.instantiateViewController(withIdentifier: "projectList") as? ProjectListViewController
        self.projectListViewController.loadView()
        self.projectListViewController.viewDidLoad()
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
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
