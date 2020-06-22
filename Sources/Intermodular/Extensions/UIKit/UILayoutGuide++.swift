//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

extension UILayoutGuide {
    public func constrainDimensions(to size: CGSize) {        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    public func constrainRect(of other: UIView) {
        other.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: other.centerXAnchor),
            centerYAnchor.constraint(equalTo: other.centerYAnchor),
            widthAnchor.constraint(equalTo: other.widthAnchor),
            heightAnchor.constraint(equalTo: other.heightAnchor)
        ])
    }
    
    public func constrainSubview(_ subview: UIView) {
        subview.constrainEdges(to: self)
    }
}
