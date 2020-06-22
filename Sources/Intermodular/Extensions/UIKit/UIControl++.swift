////
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

class UIControlEventActionTarget {
    let action: () -> ()
    
    init(parent: UIView, action: @escaping () -> ()) {
        self.action = action
        
        objc_setAssociatedObject(parent, UUID().uuidString, self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @objc func invoke() {
        action()
    }
}

extension UIControl {
    public func addActionTarget(for controlEvents: UIControl.Event = .primaryActionTriggered, action: @escaping () -> ()) {
        addTarget(
            UIControlEventActionTarget(parent: self, action: action),
            action: #selector(UIControlEventActionTarget.invoke),
            for: controlEvents
        )
    }
}
