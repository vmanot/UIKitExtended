//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXDismissButton: UIXButton {
    override open func setup() {
        super.setup()
        
        addActionTarget(for: .touchUpInside) { [weak self] in
            self?.nearestResponder(ofKind: UIViewController.self)?.parent?.dismiss(animated: true)
        }
    }
}
