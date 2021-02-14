//
//  AppCoordinator.swift
//  Employees
//
//  Created by Teodor Marinov on 12.02.21.
//

import UIKit


class AppCoordinator: Coordinator {
    
    // MARK: Properties
    private let window: UIWindow
    private var navigationController = UINavigationController()
    
    // MARK: Coordinator
    init(window: UIWindow?) {
        self.window = window ?? UIWindow(frame: UIScreen.main.bounds)
        super.init()
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        showMainModule()
    }
  
    private func showMainModule() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        addChildCoordinator(mainCoordinator)
        mainCoordinator.start()
    }
}

