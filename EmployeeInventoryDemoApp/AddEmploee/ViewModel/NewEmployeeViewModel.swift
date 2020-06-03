//
//  NewEmployeeViewModel.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 19/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import UIKit

class NewEmployeeViewModel: NSObject {
    
    let regularFont = UIFont.systemFont(ofSize: 16)
    let boldFont = UIFont.boldSystemFont(ofSize: 16)
    
    var fourDigitID: String {
        var result = ""
        repeat {
            // Create a string with a random number 0...9999
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while Set<Character>(result).count < 4
        return result
    }
    
    func getPickerList(array: [String], theameName: String, completion: @escaping (String) -> Void) {
        let theme = YBTextPickerAppearanceManager.init(
            pickerTitle         : "Select a \(theameName)",
            titleFont           : boldFont,
            titleTextColor      : .white,
            titleBackground     : nil,
            searchBarFont       : regularFont,
            searchBarPlaceholder: "Search \(theameName)",
            closeButtonTitle    : "Cancel",
            closeButtonColor    : .darkGray,
            closeButtonFont     : regularFont,
            doneButtonTitle     : "Okay",
            doneButtonColor     : nil,
            doneButtonFont      : boldFont,
            checkMarkPosition   : .Left,
            itemCheckedImage    : nil,
            itemUncheckedImage  : nil,
            itemColor           : .black,
            itemFont            : regularFont
        )
        let picker = YBTextPicker.init(with: array, appearance: theme, onCompletion: { (selectedIndexes, selectedValues) in
            if let selectedValue = selectedValues.first{
                completion(selectedValue)
            }
        }, onCancel: {
            
        })
        picker.show(withAnimation: .FromBottom)
    }
    
}
