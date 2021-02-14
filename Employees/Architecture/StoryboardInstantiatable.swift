//
//  StoryboardInstantiatable.swift
//  Employees
//
//  Created by Teodor Marinov on 14.02.21.
//

import UIKit

public protocol StoryboardInstantiatable where Self: UIViewController {
    /* Returns the name of the storyboard where the view of the ViewController is */
    static func storyboardName() -> String
    
    static func instantiateFromStoryboard(withName storyboardName: String) -> Self?
}

// Extension won't work in @objc ViewController classes, you will have to implement the method in the ViewController itself.
public extension StoryboardInstantiatable {
    static func instantiateFromStoryboard(withName storyboardName: String = Self.storyboardName()) -> Self? {
        return UIStoryboard(name: storyboardName,
                            bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: self)) as? Self
    }
}
