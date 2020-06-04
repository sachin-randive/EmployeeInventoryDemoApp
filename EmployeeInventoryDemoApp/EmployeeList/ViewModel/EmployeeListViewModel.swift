//
//  EmployeeListViewModel.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 04/06/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation

protocol EmployeeListViewModelProtocal {
    func didUpdateEmployeeInfo()
}

class EmployeeListViewModel: NSObject {
    
    var delegate: EmployeeListViewModelProtocal?
    var employeeList : [EmployeeListModel]  = []
    var filteredEmployeeList: [EmployeeListModel]  = []
    
    //MARK:- Filter Logic on searchbar
    func searchEmployee(with searchText: String, completion: @escaping () -> Void) {
        if !searchText.isEmpty {
            filteredEmployeeList = self.employeeList
            self.filteredEmployeeList = filteredEmployeeList.filter({ $0.employeeName.lowercased().contains(searchText.lowercased())})
        } else {
            self.filteredEmployeeList = self.employeeList
        }
        completion()
    }
    
    func getEmployeeList() {
        employeeList = Array(DatabaseManager.sharedInstance.getDataFromDB())
        filteredEmployeeList = Array(DatabaseManager.sharedInstance.getDataFromDB())
        self.delegate?.didUpdateEmployeeInfo()
    }
}
