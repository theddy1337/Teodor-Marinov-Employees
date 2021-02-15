//
//  UtilFunctions.swift
//  Employees
//
//  Created by Teodor Marinov on 14.02.21.
//

import UIKit

/// Delay a closure and call it async on the main thread
///
/// - Parameters:
///   - delay: the delay time in seconds
///   - closure: the closure that is called after the delay
func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue
        .main
        .asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
                    execute: closure)
}

// MARK: - Gradient
public typealias GradientAnchorPoints = (startAnchor: CGPoint, endAnchor: CGPoint)

public enum GradientDirection {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
    case custom(GradientAnchorPoints)
    
    public var anchorPoints: GradientAnchorPoints {
        switch self {
        case .leftToRight:
            return (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .rightToLeft:
            return (CGPoint(x: 1.0, y: 0.5), CGPoint(x: 0.0, y: 0.5))
        case .topToBottom:
            return (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5, y: 1.0))
        case .bottomToTop:
            return (CGPoint(x: 0.5, y: 1.0), CGPoint(x: 0.5, y: 0.0))
        case .custom(let anchorPoints):
            return anchorPoints
        }
    }
}

public extension UIView {
    /// Sets a background gradient across the provided colors with a direction and a distribution
    ///
    /// - Parameters:
    ///   - colors: The colors on which the gradient is created
    ///   - direction: The direction of the color gradient change
    ///   - distribution: The distribution of the colors (if you provide custom it should have the same amount of steps as your colors.count for best results)
    /// - Returns: The created gradient layer
    @discardableResult
    func setGradientBackground(colors: [UIColor],
                               direction: GradientDirection = .topToBottom,
                               distribution: [NSNumber]? = nil) -> CAGradientLayer {
        
        // Create a gradient layer
        let gradientLayer = CAGradientLayer()
        
        // Set the colors
        gradientLayer.colors = colors.compactMap { $0.cgColor }
        
        // Set the direction through start and end anchor point
        gradientLayer.startPoint = direction.anchorPoints.startAnchor
        gradientLayer.endPoint = direction.anchorPoints.endAnchor
        
        // Set the locations which the determine the colors distribution
        gradientLayer.locations = distribution
        
        // Set the frame and insert the gradient layer as a background
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
        return gradientLayer
    }
}

public extension CAGradientLayer {
    
    func animateGradientColors(colors: [UIColor], duration: Double = 0.5) {
        let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
        colorChangeAnimation.duration = duration
        colorChangeAnimation.fromValue = self.colors
        colorChangeAnimation.toValue = colors.compactMap { $0.cgColor }
        colorChangeAnimation.fillMode = CAMediaTimingFillMode.both
        colorChangeAnimation.isRemovedOnCompletion = false
        add(colorChangeAnimation, forKey: "colorChange")
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.colors = colors.compactMap { $0.cgColor }
        }
    }
    
}


// MARK: - Observable
class Observable<T> {
    
    typealias Closure = (T?) -> Void
    
    private var closure: Closure?
    
    var value: T? {
        didSet {
            executeClosure(newValue: value)
        }
    }
    
     // Binds a closure to be executed when the value property of the object is set (changed)
    func bind(closure: Closure?) {
        self.closure = closure
    }
    
    // Binds a closure to be executed when the value property of the object is set (changed)
    // and executes the closure immediately without waiting for the value property to change
    func bindAndFire(closure: Closure?) {
        self.closure = closure
        executeClosure(newValue: value)
    }
    
    func executeClosure(newValue: T?) {
        closure?(newValue)
    }
    
    init(_ value: T?) {
        self.value = value
    }
}

