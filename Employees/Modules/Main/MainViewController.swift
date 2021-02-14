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
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: MainViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar(title: "Employees")
        setupTableView()
    }
    
    func setupNavigationBar(title: String) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.titleView = nil
        navigationItem.title = title
        view.setGradientBackground(colors: [Constants.CustomUIColors.sirmaBlue, .white], direction: .bottomToTop)
    }
    
    // MARK: - Private
    private func setupTableView() {
        tableView.register(UINib(nibName: "\(EmployeeTableViewCell.self)", bundle: .none),
                           forCellReuseIdentifier: "\(EmployeeTableViewCell.self)")
        // Remove tableView separator
        tableView.tableFooterView = UIView()
    }

}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EmployeeTableViewCell.self)")
                as? EmployeeTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: viewModel.models[indexPath.row])
        return cell
    }
}

// MARK: - StoryboardInstantiatable
extension MainViewController: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.StoryboardNames.main
    }
}
