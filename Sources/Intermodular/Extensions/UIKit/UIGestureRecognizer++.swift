//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UIGestureRecognizer {
    public func removeFromView() {
        view?.removeGestureRecognizer(self)
    }
}
