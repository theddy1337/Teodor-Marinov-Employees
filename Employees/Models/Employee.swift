//
//  Employee.swift
//  Employees
//
//  Created by Teodor Marinov on 12.02.21.
//

import Foundation

struct Employee: Equatable {
    var empID: Int
    var projectID: Int
    var dateFrom: Date
    var dateTo: Date?
}
