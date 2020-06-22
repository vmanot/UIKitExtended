//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

// MARK: - General -

extension UIView {
    public var size: CGSize {
        get {
            return frame.size
        } set {
            frame.size = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return size.height
        } set {
            size.height = newValue
        }
    }
    
    public var width: CGFloat {
        get {
            return size.width
        } set {
            size.width = newValue
        }
    }
    
    /// Returns the frame of the view cropped to the part that is actually in display by its superview.
    open var frameInDisplay: CGRect? {
        guard let superviewFrame = superview?.frame else {
            return nil
        }
        
        var frame = self.frame
        
        if frame.origin.x > 0 {
            let xExtension = (frame.origin.x + frame.size.width) - superviewFrame.width
            if xExtension > 0 {
                frame.size.width = superviewFrame.width - frame.origin.x
            }
        } else if frame.origin.x < 0 {
            let widthInDisplay = frame.size.width + frame.origin.x
            frame.size.width = min(widthInDisplay, superviewFrame.width)
        } else {
            frame.size.width = min(frame.width, superviewFrame.width)
        }
        
        if frame.origin.y > 0 {
            let yExtension = (frame.origin.y + frame.size.height) - superviewFrame.height
            if yExtension > 0 {
                frame.size.height = superviewFrame.height - frame.origin.y
            }
        } else if frame.origin.y < 0 {
            let heightInDisplay = frame.size.height + frame.origin.y
            frame.size.height = min(heightInDisplay, superviewFrame.height)
        } else {
            frame.size.height = min(frame.height, superviewFrame.height)
        }
        
        return frame
    }
    
    public func hugTight() {
        setContentHuggingPriority(.required, for: .horizontal)
        setContentHuggingPriority(.required, for: .vertical)
    }
    
    public func hugLoose() {
        setContentHuggingPriority(.defaultLow, for: .horizontal)
        setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    public func resistCompression() {
        setContentCompressionResistancePriority(.required, for: .horizontal)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    /// An analogue to SwiftUI's `View.fixedSize()`
    public func fixSize() {
        hugTight()
        resistCompression()
    }
    
    public func setCornerRadius(_ radius: CGFloat, for corners: UIRectCorner) {
        layer.mask = CAShapeLayer().then {
            $0.path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            ).cgPath
        }
    }
}

extension UIView {
    public func addOverlay(_ view: UIView) {
        constrainSubview(view)
        
        bringSubviewToFront(view)
    }
}

// MARK: - Layout -

@objc extension UIView {
    open func constrainWidth(to width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: width)
        ])
    }
    
    open func constrainWidth(toGreaterThanOrEqualTo width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        ])
    }
    
    open func constrainHeight(to height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    open func constrainHeight(toGreaterThanOrEqualTo height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        ])
    }
    
    open func constrainDimensions(to size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ])
    }
    
    open func constrainEdges(to guide: UILayoutGuide) {
        if superview == nil {
            guide.owningView?.addSubview(self)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topAnchor.constraint(equalTo: guide.topAnchor),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    open func constrainRect(of other: UIView) {
        other.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: other.centerXAnchor),
            centerYAnchor.constraint(equalTo: other.centerYAnchor),
            widthAnchor.constraint(equalTo: other.widthAnchor),
            heightAnchor.constraint(equalTo: other.heightAnchor)
        ])
    }
    
    open func constrainEdges(of other: UIView) {
        other.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: other.topAnchor),
            bottomAnchor.constraint(equalTo: other.bottomAnchor),
            leadingAnchor.constraint(equalTo: other.leadingAnchor),
            trailingAnchor.constraint(equalTo: other.trailingAnchor)
        ])
    }
    
    open func constrainSubview(_ subview: UIView) {
        if subview.superview == nil {
            addSubview(subview)
        }
        
        constrainEdges(of: subview)
    }
}

// MARK: - Sizing -

@objc extension UIView {
    open func sizeFitting(width: CGFloat) -> CGSize {
        let layoutSize = systemLayoutSizeFitting(
            .init(width: width, height: 0),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        return .init(width: width, height: layoutSize.height)
    }
    
    open func sizeFitting(height: CGFloat) -> CGSize {
        let layoutSize = systemLayoutSizeFitting(
            .init(width: 0, height: height),
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
        
        return .init(width: layoutSize.width, height: height)
    }
    
    open var sizeFittingScreenWidth: CGSize {
        return sizeFitting(width: UIScreen.main.bounds.width)
    }
    
    open var sizeFittingScreenHeight: CGSize {
        return sizeFitting(height: UIScreen.main.bounds.height)
    }
}

// MARK: - Other -

extension NSObjectProtocol where Self: UIView {
    public func alias(_ reference: inout Self) -> Self {
        reference = self
        
        return self
    }
    
    public func alias(_ reference: inout Self?) -> Self {
        reference = self
        
        return self
    }
}
