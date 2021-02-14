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
    var numberOfRows: Int { return models.value?.count ?? 0 }
    var models = Observable<[Employee]>([])
    var sortingOptions: [EmployeeSortingOption] = [
        .empID,
        .projectID,
        .workedTogether
    ]
    
    init() {
        populateEmployeeList()
    }
    
    func sortEmployees(basedOn: EmployeeSortingOption?) {
        switch basedOn {
        case .empID:
            models.value?.sort(by: { $0.empID < $1.empID } )
        case .projectID:
            models.value?.sort(by: { $0.projectID < $1.projectID } )
        case .workedTogether:
            calculateMostTimeWorkedTogether()
        case .none:
            print("Not implemented")
        case .some(.dateStarted):
            print("Not implemented")
        }
    }
    
    // MARK: - Private
    private func calculateMostTimeWorkedTogether() {
        let crossReference = Dictionary(grouping: models.value ?? [], by: { $0.projectID })
        let duplicates = crossReference
            .filter { $1.count > 1 }                 // filter down to only those with multiple project ID
            .sorted { $0.1.count < $1.1.count }      // sort in ascending order by number of duplicates
        
        // Extract employee 1 date from to date to and convert it int odays
        // Extract employee 2 date from to date to and convert it int odays
        // Check the dates between
        print(duplicates)
    }
    
    private func populateEmployeeList() {
        let mockEmployeeList = [
            Employee(empID: 321, projectID: 12, dateFrom: Date.from(year: 2013, month: 3, day: 4), dateTo: nil),
            Employee(empID: 123, projectID: 10, dateFrom: Date.from(year: 2014, month: 1, day: 5), dateTo: Date.from(year: 2018, month: 3, day: 5)),
            Employee(empID: 3, projectID: 10, dateFrom: Date.from(year: 2014, month: 1, day: 5), dateTo: nil),
            Employee(empID: 6, projectID: 14, dateFrom: Date.from(year: 2013, month: 3, day: 4), dateTo: Date.from(year: 2019, month: 4, day: 2)),
            Employee(empID: 32, projectID: 14, dateFrom: Date.from(year: 2013, month: 3, day: 4), dateTo: Date.from(year: 2014, month: 3, day: 3)),
            Employee(empID: 54, projectID: 14, dateFrom: Date.from(year: 2014, month: 1, day: 5), dateTo: nil)
        ]
        
        models.value?.append(contentsOf: mockEmployeeList)
    }

}
