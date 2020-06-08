//
//  ProjectListUITests.swift
//  EmployeeInventoryDemoAppUITests
//
//  Created by Sachin Randive on 08/06/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import XCTest

class ProjectListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["ProjectList"].tap()
    }
    
    func testProjectTableInteraction() {
        // Assert that we are displaying the tableview
        let mainTableView = app.tables["table--currentProjectTableView"]
        XCTAssertTrue(mainTableView.exists, "The main tableview exists")
        // Get an array of cells
        let tableCells = mainTableView.cells
        if tableCells.count > 0 {
            XCTAssertTrue(true, "Finished validating the table cells")
            
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
    
    func testAddNewProjectNameAndDeleteProjectName() {
        app.navigationBars["Project List"].buttons["Add"].tap()
        let elementsQuery = app.alerts["Enter new Project"].scrollViews.otherElements
        let textField = elementsQuery.collectionViews.cells.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("BT")
        elementsQuery.buttons["Submit"].tap()
        
        let tableCurrentprojecttableviewTable = app.tables["table--currentProjectTableView"]
        let btStaticText = tableCurrentprojecttableviewTable.staticTexts["BT"]
        btStaticText.tap()
        btStaticText.swipeLeft()
        tableCurrentprojecttableviewTable.buttons["trailing0"].tap()
        tableCurrentprojecttableviewTable.swipeDown()
    }
}

