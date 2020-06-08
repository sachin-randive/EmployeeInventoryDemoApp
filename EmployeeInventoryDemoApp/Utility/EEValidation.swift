//
//  EEValidation.swift
//  EmployeeInventoryDemoApp
//
//  Created by Sachin Randive on 05/06/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import UIKit

let set = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ ")

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case employeeName
    case employeeBand
    case employeeDesignation
    case employeeCompetency
    case employeeCurrentProject
}

enum VaildatorFactory {
    
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .employeeName: return employeeNameValidator()
        case .employeeBand: return checkNotNil()
        case .employeeDesignation: return employeeDesignationValidator()
        case .employeeCompetency: return competencyValidator()
        case .employeeCurrentProject: return projectNameValidator()
        }
    }
}

struct checkNotNil: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Invalid band")}
        return value
    }
}

class competencyValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Please select the competency")}
        return value
    }
}

class projectNameValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Please select the project name")}
        return value
    }
}


struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct employeeNameValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("name must contain more than 3 characters" )
        }
        guard value.count < 30 else {
            throw ValidationError("name shoudn't conain more than 30 characters" )
        }
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: value, options: [], range: NSMakeRange(0, value.count)) != nil {
                throw ValidationError("Invalid name, Must not contain Numbers in Name")
            }
        } catch {
            throw ValidationError("Invalid name, Must not contain Numbers in Name")
        }
        return value
    }
}

struct employeeDesignationValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        guard value.count >= 4 else {
            throw ValidationError("Designation must contain more than 4 characters" )
        }
        guard value.count < 30 else {
            throw ValidationError("Designation shoudn't conain more than 30 characters" )
        }
        
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z ].*", options: [])
            if regex.firstMatch(in: value, options: [], range: NSMakeRange(0, value.count)) != nil {
                throw ValidationError("Invalid Designation, Must not contain Numbers in Designation")
            }
        } catch {
            throw ValidationError("Invalid Designation, Must not contain Numbers in Designation")
        }
        return value
    }
}

