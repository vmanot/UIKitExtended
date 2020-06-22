//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

@objc public protocol UIViewConvertible {
    func toUIView() -> UIView
}

// MARK: Implementations -

extension UIView: UIViewConvertible {
    public func toUIView() -> UIView {
        return self
    }
}

extension UIViewController: UIViewConvertible {
    public func toUIView() -> UIView {
        return view
    }
}
