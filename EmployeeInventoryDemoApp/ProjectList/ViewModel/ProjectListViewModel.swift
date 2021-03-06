//
//  ProjectListViewModel.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import UIKit

class ProjectListViewModel {
    var projectList : [ProjectListModel]  = []
    
    func getProjectList() {
        projectList = Array(DatabaseManager.sharedInstance.getProjectNameArray())
    }
}

