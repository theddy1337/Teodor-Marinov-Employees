//
//  MainViewModel.swift
//  Employees
//
//  Created by Teodor Marinov on 14.02.21.
//

import Foundation

enum EmployeeSortingOption: String {
    case empID = "Employee ID"
    case projectID = "Project ID"
    case dateStarted = "Project start date"
    case workedTogether = "Most time worked together"
}

class MainViewModel: MainViewModelProtocol {
    
    // MARK: - Variables
    var numberOfSections: Int { return 1 }
    var numberOfRows: Int { return models.count }
    var models: [Employee] = []
    
    var sortingOptions: [EmployeeSortingOption] = [
        .empID,
        .projectID,
        .dateStarted,
        .workedTogether
    ]
    
    init() {
        populateEmployeeList()
    }
    
    func sortEmployees(basedOn: Int) {
        // TODO: Implement
    }
    
    // MARK: - Private
    private func populateEmployeeList() {
        let mockEmployeeList = [
            Employee(empID: 321, projectID: 12, dateFrom: Date.from(year: 2013, month: 3, day: 4), dateTo: nil),
            Employee(empID: 123, projectID: 10, dateFrom: Date.from(year: 2014, month: 1, day: 5), dateTo: Date.from(year: 2018, month: 3, day: 5)),
            Employee(empID: 3, projectID: 10, dateFrom: Date.from(year: 2014, month: 1, day: 5), dateTo: nil),
            Employee(empID: 6, projectID: 14, dateFrom: Date.from(year: 2013, month: 3, day: 4), dateTo: Date.from(year: 2019, month: 4, day: 2)),
            Employee(empID: 32, projectID: 14, dateFrom: Date.from(year: 2013, month: 3, day: 4), dateTo: Date.from(year: 2014, month: 3, day: 3)),
            Employee(empID: 54, projectID: 14, dateFrom: Date.from(year: 2014, month: 1, day: 5), dateTo: nil)
        ]
        
        models.append(contentsOf: mockEmployeeList)
    }

}
