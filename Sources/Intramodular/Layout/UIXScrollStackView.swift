//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXScrollStackView: UIXScrollView {
    private var contentView = UIXStackView()
    private var contentViewAxisConstraint: NSLayoutConstraint?
    
    open var axis: NSLayoutConstraint.Axis {
        get {
            contentView.axis
        } set {
            contentView.axis = newValue
            
            updateContentViewAxisConstraint()
        }
    }
    
    open var distribution: UIStackView.Distribution {
        get {
            contentView.distribution
        } set {
            contentView.distribution = newValue
        }
    }
    
    open var alignment: UIStackView.Alignment {
        get {
            contentView.alignment
        } set {
            contentView.alignment = newValue
        }
    }
    
    open var spacing: CGFloat {
        get {
            contentView.spacing
        } set {
            contentView.spacing = newValue
        }
    }
            
    override open var contentInset: UIEdgeInsets {
        get {
            contentView.layoutMargins
        } set {
            contentView.layoutMargins = newValue
        }
    }

    open func addArrangedSubview(_ view: UIView) {
        contentView.addArrangedSubview(view)
    }
        
    override open func setup() {
        super.setup()
        
        contentLayoutGuide.constrainSubview(contentView)
        
        updateContentViewAxisConstraint()
    }
    
    private func updateContentViewAxisConstraint() {
        contentViewAxisConstraint?.isActive = false
        
        if contentView.axis == .vertical {
            contentViewAxisConstraint = contentLayoutGuide
                .widthAnchor
                .constraint(equalTo: frameLayoutGuide.widthAnchor)
        } else {
            contentViewAxisConstraint = contentLayoutGuide
                .heightAnchor
                .constraint(equalTo: frameLayoutGuide.heightAnchor)
        }
        
        contentViewAxisConstraint?.isActive = true
    }
}

extension UIXScrollStackView {
    /// Returns a horizontal stack view whose parameters can either be specified or left to defaults.
    public static func horizontal(
        distribution: UIStackView.Distribution = .equalSpacing,
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = 8,
        @ArrayBuilder<UIViewConvertible> views: () -> [UIViewConvertible]
    ) -> UIXScrollStackView {
        UIXScrollStackView().then {
            $0.axis = .horizontal
            $0.distribution = distribution
            $0.alignment = alignment
            $0.spacing  = spacing
            
            views()
                .lazy
                .map({ $0.toUIView() })
                .forEach($0.addArrangedSubview)
        }
    }
    
    /// Returns a vertical stack view whose parameters can either be specified or left to defaults.
    public static func vertical(
        distribution: UIStackView.Distribution = .equalSpacing,
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = 8,
        @ArrayBuilder<UIViewConvertible> views: () -> [UIViewConvertible]
    ) -> UIXScrollStackView {
        UIXScrollStackView().then {
            $0.axis = .vertical
            $0.distribution = distribution
            $0.alignment = alignment
            $0.spacing  = spacing
            
            views()
                .lazy
                .map({ $0.toUIView() })
                .forEach($0.addArrangedSubview)
        }
    }
}
