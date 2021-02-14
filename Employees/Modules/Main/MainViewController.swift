//
//  MainViewController.swift
//  Employees
//
//  Created by Teodor Marinov on 11.02.21.
//

import UIKit

protocol MainViewModelProtocol {
    func sortEmployees(basedOn: Int)
}

class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: MainViewModel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupNavigationBar(title: Constants.ViewControllerNames.employees)
    }
    
    // MARK: - UIPicker
    private func displaySortingOptions() {
        var actions: [(String, UIAlertAction.Style)] = []
        // Appending the sorting options into the ActionSheet
        viewModel.sortingOptions.forEach( { actions.append(($0.rawValue, UIAlertAction.Style.default)) } )
        actions.append((Constants.ActionSheetSorter.cancel, UIAlertAction.Style.cancel))
        
        Alerts.showActionsheet(viewController: self,
                               title: Constants.ActionSheetSorter.title,
                               message: Constants.ActionSheetSorter.message,
                               actions: actions) { [weak self] selectedIndex in
            self?.viewModel.sortEmployees(basedOn: selectedIndex)
        }
    }
    
    // MARK: - Private
    private func setupUI() {
        view.setGradientBackground(colors: [Constants.CustomUIColors.sirmaBlue, .white],
                                   direction: .bottomToTop)
    }
    
    private func setupNavigationBar(title: String) {
        createSortButton()
        createImportButton()
        navigationItem.title = title
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "\(EmployeeTableViewCell.self)", bundle: .none),
                           forCellReuseIdentifier: "\(EmployeeTableViewCell.self)")
        // Remove tableView separator
        tableView.tableFooterView = UIView()
    }
    
    private func createSortButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sort",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapSortButton))
    }
    
    private func createImportButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Import",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapImportButton))
    }
    
    @objc private func didTapSortButton() {
        displaySortingOptions()
    }
    
    @objc private func didTapImportButton() {
        // TODO: Implement
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
