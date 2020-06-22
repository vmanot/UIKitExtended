//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

/// The alignment of a view with respect to its container.
public enum UIAlignment {
    case center
    case leading
    case trailing
    case top
    case bottom
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
}

// MARK: - Helpers -

extension UILayoutGuide {    
    public func constrainSubview(
        _ subview: UIView,
        to alignment: UIAlignment,
        offset: CGPoint = .zero
    ) {
        subview.constrain(alignment, to: self, offset: offset)
    }
}

extension UIView {
    /// Aligns the receiver to a given parent.
    public func constrain(
        _ alignment: UIAlignment,
        to parent: UIView,
        offset: CGPoint = .zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if superview == nil {
            parent.addSubview(self)
        }
        
        switch alignment {
            case .center:
                NSLayoutConstraint.activate([
                    centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset.x),
                    centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset.x),
                ])
            case .leading:
                NSLayoutConstraint.activate([
                    leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: offset.x),
                    centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset.y),
                ])
            case .trailing:
                NSLayoutConstraint.activate([
                    trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: offset.x),
                    centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset.y),
                ])
            case .top:
                NSLayoutConstraint.activate([
                    topAnchor.constraint(equalTo: parent.topAnchor, constant: offset.y),
                    centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset.x),
                ])
            case .bottom:
                NSLayoutConstraint.activate([
                    bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: offset.y),
                    centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset.x),
                ])
            case .topLeading:
                NSLayoutConstraint.activate([
                    topAnchor.constraint(equalTo: parent.topAnchor, constant: offset.y),
                    leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: offset.x),
                ])
            case .topTrailing:
                NSLayoutConstraint.activate([
                    topAnchor.constraint(equalTo: parent.topAnchor, constant: offset.y),
                    trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: offset.x),
                ])
            case .bottomLeading:
                NSLayoutConstraint.activate([
                    bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: offset.y),
                    leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: offset.x),
                ])
            case .bottomTrailing:
                NSLayoutConstraint.activate([
                    bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: offset.y),
                    trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: offset.x),
                ])
        }
    }
    
    /// Aligns the receiver to a given parent.
    public func constrain(
        _ alignment: UIAlignment,
        to parent: UILayoutGuide,
        offset: CGPoint = .zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if superview == nil {
            parent.owningView?.addSubview(self)
        }
        
        switch alignment {
            case .center:
                NSLayoutConstraint.activate([
                    centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset.x),
                    centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset.x),
                ])
            case .leading:
                NSLayoutConstraint.activate([
                    leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: offset.x),
                    centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset.y),
                ])
            case .trailing:
                NSLayoutConstraint.activate([
                    trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: offset.x),
                    centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: offset.y),
                ])
            case .top:
                NSLayoutConstraint.activate([
                    topAnchor.constraint(equalTo: parent.topAnchor, constant: offset.y),
                    centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset.x),
                ])
            case .bottom:
                NSLayoutConstraint.activate([
                    bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: offset.y),
                    centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: offset.x),
                ])
            case .topLeading:
                NSLayoutConstraint.activate([
                    topAnchor.constraint(equalTo: parent.topAnchor, constant: offset.y),
                    leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: offset.x),
                ])
            case .topTrailing:
                NSLayoutConstraint.activate([
                    topAnchor.constraint(equalTo: parent.topAnchor, constant: offset.y),
                    trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: offset.x),
                ])
            case .bottomLeading:
                NSLayoutConstraint.activate([
                    bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: offset.y),
                    leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: offset.x),
                ])
            case .bottomTrailing:
                NSLayoutConstraint.activate([
                    bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: offset.y),
                    trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: offset.x),
                ])
        }
    }
    
    public func constrainSubview(
        _ subview: UIView,
        to alignment: UIAlignment,
        offset: CGPoint = .zero
    ) {
        subview.constrain(alignment, to: self, offset: offset)
    }
}
