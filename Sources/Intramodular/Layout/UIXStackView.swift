//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A modern `UIStackView` subclass.
///
/// This subclass provides an intrinsic content size.
open class UIXStackView: UIStackView, UIXViewProtocol {
    override open var layoutMargins: UIEdgeInsets {
        get {
            super.layoutMargins
        } set {
            super.layoutMargins = newValue
            
            isLayoutMarginsRelativeArrangement = true
        }
    }
    
    override open var axis: NSLayoutConstraint.Axis {
        didSet {
            super.invalidateIntrinsicContentSize()
        }
    }
    
    override open var distribution: Distribution {
        didSet {
            super.invalidateIntrinsicContentSize()
        }
    }
    
    override open var alignment: Alignment {
        didSet {
            super.invalidateIntrinsicContentSize()
        }
    }
    
    override open var spacing: CGFloat {
        didSet {
            super.invalidateIntrinsicContentSize()
        }
    }
    
    /// The preferred intrinsic width to be used if possible.
    open var preferredIntrinsicWidth: CGFloat? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    /// The preferred intrinsic height to be used if possible.
    open var preferredIntrinsicHeight: CGFloat? {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        var size = CGSize.zero
        
        var hasSubviewWithNoIntrinsicWidth: Bool = false
        var hasSubviewWithNoIntrinsicHeight: Bool = false
        
        for view in arrangedSubviews {
            let intrinsicContentSize = view.intrinsicContentSize
            
            if intrinsicContentSize.width == UIView.noIntrinsicMetric {
                hasSubviewWithNoIntrinsicWidth = true
            }
            
            if intrinsicContentSize.height == UIView.noIntrinsicMetric {
                hasSubviewWithNoIntrinsicHeight = true
            }
            
            if hasSubviewWithNoIntrinsicWidth && hasSubviewWithNoIntrinsicHeight {
                return super.intrinsicContentSize
            }
            
            switch axis {
                case .horizontal:
                    size.width += intrinsicContentSize.width
                    size.height = max(size.height, intrinsicContentSize.height)
                case .vertical:
                    size.width = max(size.width, intrinsicContentSize.width)
                    size.height += intrinsicContentSize.height
                default:
                    break
            }
        }
        
        if arrangedSubviews.count != 0 {
            let totalSpacing = .init(arrangedSubviews.count - 1) * spacing
            
            switch axis {
                case .horizontal:
                    size.width += totalSpacing
                case .vertical:
                    size.height += totalSpacing
                default:
                    break
            }
        }
        
        if hasSubviewWithNoIntrinsicWidth {
            size.width = UIView.noIntrinsicMetric
        }
        
        if hasSubviewWithNoIntrinsicHeight {
            size.height = UIView.noIntrinsicMetric
        }
        
        if let preferredIntrinsicWidth = preferredIntrinsicWidth {
            size.width = preferredIntrinsicWidth
        }
        
        if let preferredIntrinsicHeight = preferredIntrinsicHeight {
            size.height = preferredIntrinsicHeight
        }
        
        if isLayoutMarginsRelativeArrangement {
            size.width += layoutMargins.horizontal
            size.height += layoutMargins.vertical
        }
        
        return size
    }
    
    public init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    public required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
    
    override open func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        super.invalidateIntrinsicContentSize()
        
        setNeedsLayout()
    }
}

extension UIXStackView {
    /// Returns a horizontal stack view whose parameters can either be specified or left to defaults.
    public static func horizontal(
        distribution: UIStackView.Distribution = .equalSpacing,
        alignment: UIStackView.Alignment = .center,
        spacing: CGFloat = 8,
        preferredIntrinsicWidth: CGFloat? = nil,
        preferredIntrinsicHeight: CGFloat? = nil,
        @ArrayBuilder<UIViewConvertible> views: () -> [UIViewConvertible]
    ) -> UIXStackView {
        UIXStackView().then {
            $0.axis = .horizontal
            $0.distribution = distribution
            $0.alignment = alignment
            $0.spacing  = spacing
            $0.preferredIntrinsicWidth = preferredIntrinsicWidth
            $0.preferredIntrinsicHeight = preferredIntrinsicHeight
            
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
        preferredIntrinsicWidth: CGFloat? = nil,
        preferredIntrinsicHeight: CGFloat? = nil,
        @ArrayBuilder<UIViewConvertible> views: () -> [UIViewConvertible]
    ) -> UIXStackView {
        UIXStackView().then {
            $0.axis = .vertical
            $0.distribution = distribution
            $0.alignment = alignment
            $0.spacing  = spacing
            $0.preferredIntrinsicWidth = preferredIntrinsicWidth
            $0.preferredIntrinsicHeight = preferredIntrinsicHeight
            
            views()
                .lazy
                .map({ $0.toUIView() })
                .forEach($0.addArrangedSubview)
        }
    }
}
