//
//  addEmployeeUITests.swift
//  EmployeeInventoryDemoAppUITests
//
//  Created by Sachin Randive on 08/06/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import XCTest

class addEmployeeUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        app.navigationBars["Employee List"].buttons["Add"].tap()
    }
    
    func testPartialDataEntryOfEmployee() {
        let elementsQuery = app.scrollViews.otherElements
        let name = elementsQuery.textFields["Enter your Name"]
        XCTAssertTrue(name.exists)
        name.tap()
        name.typeText("Ravi Patil")
        
        let enterYourBandTextField = elementsQuery.textFields["Enter your Band"]
        XCTAssertTrue(enterYourBandTextField.exists)
        enterYourBandTextField.tap()
        enterYourBandTextField.typeText("U4")
        
        let enterYourDesignationTextField = elementsQuery.textFields["Enter your Designation"]
        enterYourDesignationTextField.tap()
        enterYourDesignationTextField.typeText("Lead Associate")
    }
    
    
}
