//
//  EmployeeViewModel.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    private var database:Realm
    static let sharedInstance = DatabaseManager()
    
    private init() {
        database = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func getDataFromDB() -> Results<EmployeeListModel> {
        let results: Results<EmployeeListModel> = database.objects(EmployeeListModel.self)
        return results
    }
    
    func addData(object: EmployeeListModel) {
        try! database.write {
            database.add(object) // database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func deleteAllDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: EmployeeListModel) {
        try! database.write {
            database.delete(object)
        }
    }
    func saveProjectListArray() {
        let projectNames: [String] = ["ATT FirstNet", "Sawari Cab App", "Resource Management App", "ATT", "TMobile", " Bell Canada"]
        var projectLists:[ProjectListModel] = []
        for name in projectNames {
            let projectListModel = ProjectListModel()
            projectListModel.projectName = name
            projectLists.append(projectListModel)
            try! database.write {
                
                database.add(projectLists)
            }
            
        }
    }
    func getProjectNameArray() ->Results<ProjectListModel> {
    let results: Results<ProjectListModel> = database.objects(ProjectListModel.self)
    return results
    }
    
    func addProject(object: ProjectListModel) {
           try! database.write {
               database.add(object)
           }
       }
        
}
