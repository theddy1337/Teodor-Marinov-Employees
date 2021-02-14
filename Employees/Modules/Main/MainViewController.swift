//
//  MainViewController.swift
//  Employees
//
//  Created by Teodor Marinov on 11.02.21.
//

import UIKit

protocol MainViewModelProtocol {
    func sortEmployees(basedOn: EmployeeSortingType)
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Employees")
    }
    
    func setupNavigationBar(title: String) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = nil
        navigationItem.title = title
    }

}

// MARK: - StoryboardInstantiatable
extension MainViewController: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.StoryboardNames.main
    }
}
