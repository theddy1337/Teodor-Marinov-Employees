//
//  EmployeeTableViewCell.swift
//  Employees
//
//  Created by Teodor Marinov on 14.02.21.
//

import UIKit

protocol Configurable {
    func configure(with employee: Employee?)
}

class EmployeeTableViewCell: UITableViewCell, Configurable {

    // MARK: - Properties
    @IBOutlet private weak var employeeIDLabel: UILabel!
    @IBOutlet private weak var projectIDLabel: UILabel!
    @IBOutlet private weak var dateFromLabel: UILabel!
    @IBOutlet private weak var dateToLabel: UILabel!
    
    private let dateFormatter = DateFormatter()
    
    func configure(with employee: Employee?) {
        guard let employee = employee else { return }
        
        employeeIDLabel.text = "\(employee.empID)"
        projectIDLabel.text = "\(employee.projectID)"
        dateFromLabel.text = dateFormatter.dateToString(employee.dateFrom, dateFormat: .yearMonthDay)
        // If the date given to the dateFormatter is nil, that means the employee is still assigned to that project
        // In that case the dateFormatter returns the current day(today).
        dateToLabel.text = dateFormatter.dateToString(employee.dateTo, dateFormat: .yearMonthDay)
    }
    
}
