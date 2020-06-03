//
//  EmployeeModel.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class EmployeeListModel: Object {
    @objc dynamic var employeeID = "1"
    @objc dynamic var employeeName = ""
    @objc dynamic var employeeBand = ""
    @objc dynamic var employeeDesignation = ""
    @objc dynamic var employeeCompetency = ""
    @objc dynamic var employeeCurrentProject = ""
    
//    override static func primaryKey() -> String? {
//      return "id"
//    }
}
