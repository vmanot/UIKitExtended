//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UINavigationController {
    open func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        pushViewController(viewController, animated: animated)
        
        guard let completion = completion else {
            return
        }
        
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async(execute: { completion() })
            return
        }
        
        coordinator.animate(alongsideTransition: nil, completion: { _ in completion() })
    }
    
    open func pop(animated: Bool, completion: (() -> Void)? = nil) {
        popViewController(animated: animated)
        
        guard let completion = completion else {
            return
        }
        
        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async(execute: { completion() })
            return
        }
        
        coordinator.animate(alongsideTransition: nil, completion: { _ in completion() })
    }
}
