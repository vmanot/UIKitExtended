//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UIViewController {
    open var topMostViewController: UIViewController? {
        var result: UIViewController? = self
        while (result?.presentedViewController != nil) {
            result = result?.presentedViewController
        }
        return result
    }
    
    open func addChildViewController(_ controller: UIViewController) {
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
        
    open func constrainChild(_ controller: UIViewController) {
        addChildViewController(controller)
        
        view.constrainSubview(controller.view)
    }

    open func addAndConstrainChildViewController(_ controller: UIViewController) {
        addChild(controller)
        view.addSubview(controller.view)
        view.constrainSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    open func pushOrPresent(_ viewController: UIViewController, animated: Bool, completion: (() -> ())? = nil) {
        if let navigationController = navigationController {
            navigationController.push(viewController, animated: animated, completion: completion)
        } else {
            present(viewController, animated: animated, completion: completion)
        }
    }
    
    open func dismissSelf(animated: Bool = true, completion: (() -> ())? = nil) {
        if let navigationController = navigationController, navigationController.visibleViewController == self {
            navigationController.popViewController(animated: animated)
            completion?()
        } else {
            presentingViewController?.dismiss(animated: animated, completion: completion)
        }
    }
}
