//
//  AppDelegate.swift
//  Employees
//
//  Created by Teodor Marinov on 11.02.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        setupAppCoordinator()
        return true
    }
    
    // MARK: - Private Setup
    private func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    private func setupAppCoordinator() {
        guard let window = window else {
            assertionFailure("Could not configure AppCoordinator - missing window.")
            return
        }
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }

}

