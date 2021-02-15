//
//  MainViewController.swift
//  Employees
//
//  Created by Teodor Marinov on 11.02.21.
//

import UIKit

protocol MainViewModelProtocol {
    var models: Observable<[Employee]> { get }
    var numberOfSections: Int { get }
    var numberOfRows: Int { get }
    var sortingOptions: [EmployeeSortingOption] { get }
    var shouldRefreshStatisticsView: Observable<Bool> { get }
    func sortEmployees(basedOn: EmployeeSortingOption?)
}

class MainViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalTimeWorkedTogetherLabel: UILabel!
    @IBOutlet private weak var employeesCoupleNamesLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: MainViewModelProtocol!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        bindToEmployees()
        bindToStatisticView()
        setupNavigationBar(title: Constants.ViewControllerNames.employees)
    }
    
    // MARK: - UIActionSheet
    private func displaySortingOptions() {
        var actions: [(String, UIAlertAction.Style)] = []
        // Creating the sorting options into the ActionSheet
        viewModel.sortingOptions.forEach( { actions.append(($0.rawValue, UIAlertAction.Style.default)) } )
        // Creating cancel option as well
        actions.append((Constants.ActionSheetSorter.cancel, UIAlertAction.Style.cancel))
        
        Alerts.showActionsheet(viewController: self,
                               title: Constants.ActionSheetSorter.title,
                               message: Constants.ActionSheetSorter.message,
                               actions: actions) { [weak self] employeeSortingOption in
            self?.viewModel.sortEmployees(basedOn: employeeSortingOption)
        }
    }
    
    // MARK: - Private
    private func bindToStatisticView() {
        viewModel.shouldRefreshStatisticsView.bind { [weak self] _ in
            self?.totalTimeWorkedTogetherLabel.isHidden = false
            self?.employeesCoupleNamesLabel.isHidden = false
            self?.tableView.reloadData()
        }
    }
    
    private func bindToEmployees() {
        viewModel.models.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        view.setGradientBackground(colors: [Constants.CustomUIColors.sirmaBlue, .white],
                                   direction: .bottomToTop)
    }
    
    private func setupNavigationBar(title: String) {
        createSortButton()
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
    
    @objc private func didTapSortButton() {
        displaySortingOptions()
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
        
        cell.configure(with: viewModel.models.value?[indexPath.row])
        return cell
    }
}

// MARK: - StoryboardInstantiatable
extension MainViewController: StoryboardInstantiatable {
    static func storyboardName() -> String {
        return Constants.StoryboardNames.main
    }
}
