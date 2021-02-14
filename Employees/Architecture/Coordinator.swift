//
//  Coordinator.swift
//  Employees
//
//  Created by Teodor Marinov on 14.02.21.
//

import Foundation

class Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    /// Start The Coordinator !!! SHOULD BE OVERRIDEN IN EACH SUBCLASS !!!
    func start(animated: Bool = true) {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    /// Finish The Coordinator !!!
    /// The base class automatically handles memory management:
    ///     - removing `self` from childCoordinator's array of the parent coordinator
    /// Subclasses should provide custom navigation action: pop/dimiss/etc...
    func finish() {
        parentCoordinator?.removeChildCoordinator(self)
    }
    
    /// Adds a child coordinator to the current childCoordinators array
    ///
    /// - Parameter coordinator: the coordinator to add
    @discardableResult
    func addChildCoordinator(_ coordinator: Coordinator?) -> Bool {
        guard let coordinator = coordinator else { return false }
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        
        return true
    }
    
    func addChildCoordinators(_ coordinators: [Coordinator]) {
        childCoordinators.append(contentsOf: coordinators)
    }
    
    /// Removes a child coordinator if such exists from the childCoordinators array
    ///
    /// - Parameter coordinator: the coordinator to remove
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(of: coordinator) {
            childCoordinators.remove(at: index)
        } else {
            print("Couldn't remove coordinator: \(coordinator). It's not a child coordinator.")
        }
    }
    
    /// Removes all child coordinators of a generic type if they exist from the childCoordinators array
    ///
    /// - Parameter type: the type by which the array is filtered
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        childCoordinators = childCoordinators.filter { $0 is T  == false }
    }
    
    /// Removes all child coordinators from the childCoordinators array
    func removeAllChildCoordinators() {
        childCoordinators.removeAll()
    }
    
}

extension Coordinator: Equatable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}

extension Coordinator {
    func firstParent<T: Coordinator>(of type: T.Type) -> T? {
        if let parentOfType = parentCoordinator as? T {
            return parentOfType
        }
        return parentCoordinator?.firstParent(of: type)
    }
}
