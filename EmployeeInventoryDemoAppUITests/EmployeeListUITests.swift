//
//  EmployeeListUITests.swift
//  EmployeeInventoryDemoAppUITests
//
//  Created by Sachin Randive on 08/06/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import XCTest

class EmployeeListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testForCellExistence() {
        let detailstable = app.tables.matching(identifier:"table--employeeTableView")
        let firstCell = detailstable.cells.element(matching: .cell, identifier: "myCell_0")
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
        firstCell.tap()
    }
    
    func testTableInteraction() {
        // Assert that we are displaying the tableview
        let mainTableView = app.tables["table--employeeTableView"]
        XCTAssertTrue(mainTableView.exists, "The main tableview exists")
        // Get an array of cells
        let tableCells = mainTableView.cells
        if tableCells.count > 0 {
            XCTAssertTrue(true, "Finished validating the table cells")
            
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
    
    func testDetailsListOfEmployee() {
        let app = XCUIApplication()
        let searchEmployeeSearchField = app.searchFields["Search Employee"]
        searchEmployeeSearchField.tap()
        searchEmployeeSearchField.typeText("As")
        let clearTextButton = searchEmployeeSearchField.buttons["Clear text"]
        clearTextButton.tap()
    }
    
}
