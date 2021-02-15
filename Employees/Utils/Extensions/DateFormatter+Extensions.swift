//
//  DateFormatter+Extensions.swift
//  Employees
//
//  Created by Teodor Marinov on 14.02.21.
//

import Foundation

public enum DateFormat: String {
    
    case yearMonthDay = "yyy-MM-dd"
    /// Example: Jul 02, 2020
    case monthDayCommaYear = "MMM dd, yyyy"
    /// Example: Jul 02 2020
    case monthDayYear = "MMM dd yyyy"
    case monthDay = "MMM dd"
    /// Separated with "/" and leading 0 is cut.
    /// Example: 7/7/20; 12/26/20.
    case monthDayYearSlashed = "M/d/yy"
}

extension DateFormatter {
    
    func dateToString(_ date: Date?, dateFormat: DateFormat) -> String {
        self.dateFormat = dateFormat.rawValue
        self.locale = Locale(identifier: "en_US")
        return string(from: date ?? Date())
    }
    
}

