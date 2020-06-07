//
//  EmployeeModel.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class EmployeeListModel: RealmSwift.Object, Codable {
    
    @objc dynamic var employeeID = "1111"
    @objc dynamic var employeeName = ""
    @objc dynamic var employeeBand = ""
    @objc dynamic var employeeDesignation = ""
    @objc dynamic var employeeCompetency: String = ""
    @objc dynamic var employeeCurrentProject = ""
    
    override static func primaryKey() -> String? {
        return "employeeID"
    }
    
    private enum CodingKeys: String, CodingKey {
        case employeeID
        case employeeName
        case employeeBand
        case employeeDesignation
        case employeeCompetency
        case employeeCurrentProject
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        employeeID = try container.decode(String.self, forKey: .employeeID)
        employeeName = try container.decode(String.self, forKey: .employeeName)
        employeeBand = try container.decode(String.self, forKey: .employeeBand)
        employeeDesignation = try container.decode(String.self, forKey: .employeeDesignation)
        employeeCompetency = try container.decode(String.self, forKey: .employeeCompetency)
        employeeCurrentProject = try container.decode(String.self, forKey: .employeeCurrentProject)
    }
    
    convenience init(ID: String, name: String, band: String, designation: String, competency: String, project: String) {
        self.init()
        self.employeeID = ID
        self.employeeName = name
        self.employeeBand = band
        self.employeeDesignation = designation
        self.employeeCompetency = competency
        self.employeeCurrentProject = project
    }
}
