//
//  MainCoordinator.swift
//  Employees
//
//  Created by Teodor Marinov on 14.02.21.
//

import UIKit

class MainCoordinator: Coordinator {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    override func start(animated: Bool = true) {
        showMainScene()
    }
    
    // MARK: - Private
    private func showMainScene() {
        guard let mainViewController = MainViewController.instantiateFromStoryboard() else { return }
        mainViewController.viewModel = MainViewModel()
        navigationController?.pushViewController(mainViewController, animated: true)
    }
}
