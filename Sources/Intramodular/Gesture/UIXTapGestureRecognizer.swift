//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

public final class UIXTapGestureRecognizer: UITapGestureRecognizer {
    private var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
        
        super.init(target: nil, action: nil)
        
        addTarget(self, action: #selector(performAction))
    }
    
    @objc private func performAction() {
        action()
    }
}

// MARK: - API -

extension UIView {
    public func onTapGesture(perform action: @escaping () -> Void) {
        isUserInteractionEnabled = true
        
        addGestureRecognizer(UIXTapGestureRecognizer(action: action))
    }
}
