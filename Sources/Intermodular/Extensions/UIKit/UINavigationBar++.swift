//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UINavigationBar {
    @inlinable
    public var isDefaultTransparent: Bool {
        get {
            return true
                && backgroundImage(for: .default)?.size == .zero
                && shadowImage?.size == .zero
        } set {
            setBackgroundImage(newValue ? UIImage() : nil, for: .default)
            shadowImage = newValue ? UIImage() : nil
        }
    }
}
