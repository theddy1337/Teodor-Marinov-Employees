//
//  Alerts.swift
//  Employees
//
//  Created by Teodor Marinov on 14.02.21.
//

import UIKit

class Alerts {
    static func showActionsheet(viewController: UIViewController,
                                title: String,
                                message: String,
                                actions: [(String, UIAlertAction.Style)],
                                completion: @escaping (_ index: EmployeeSortingOption?) -> Void) {
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for (title, style) in actions {
            let alertAction = UIAlertAction(title: title, style: style) { (_) in
                completion(EmployeeSortingOption(rawValue: title))
            }
            alertViewController.addAction(alertAction)
        }
        viewController.present(alertViewController, animated: true, completion: nil)
    }
}
