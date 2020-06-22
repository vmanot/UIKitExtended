//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXView: UIView, UIXViewProtocol {
    open var isPassthrough: Bool = false
    open var customIntrinsicContentSize: CGSize?
    
    override open var intrinsicContentSize: CGSize {
        guard !isHidden else {
            return .zero
        }
        
        return customIntrinsicContentSize ?? super.intrinsicContentSize
    }
    
    override open var isHidden: Bool {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
    
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        updateRelativeSize()
    }
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard isPassthrough else {
            return super.point(inside: point, with: event)
        }
        
        for subview in subviews {
            if true
                && !subview.isHidden
                && subview.isUserInteractionEnabled
                && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        
        return false
    }
    
    // MARK: Relative Sizing
    
    private var relativeWidthMultiplier: CGFloat?
    private var relativeWidthConstant: CGFloat?
    private var relativeHeightMultiplier: CGFloat?
    private var relativeHeightConstant: CGFloat?
    private var relativeWidthConstraint: NSLayoutConstraint?
    private var relativeHeightConstraint: NSLayoutConstraint?
    
    func updateRelativeSize() {
        NSLayoutConstraint.deactivate([relativeWidthConstraint, relativeHeightConstraint].compactMap({ $0 }))
        
        guard let superview = superview else {
            return
        }
        
        if let relativeWidthMultiplier = relativeWidthMultiplier {
            relativeWidthConstraint = widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: relativeWidthMultiplier, constant: relativeWidthConstant ?? 0)
        }
        
        if let relativeHeightMultiplier = relativeHeightMultiplier {
            relativeHeightConstraint = heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: relativeHeightMultiplier, constant: relativeHeightConstant ?? 0)
        }
        
        NSLayoutConstraint.activate([relativeWidthConstraint, relativeHeightConstraint].compactMap({ $0 }))
        
        superview.setNeedsUpdateConstraints()
    }
    
    public final func setRelativeWidth(_ multiplier: CGFloat, offset: CGFloat = 0) {
        relativeWidthMultiplier = multiplier
        relativeWidthConstant = offset
        
        updateRelativeSize()
    }
    
    public final func setRelativeHeight(_ multiplier: CGFloat?, offset: CGFloat = 0) {
        relativeHeightMultiplier = multiplier
        relativeHeightConstant = offset
        
        updateRelativeSize()
    }
    
    public convenience init(_ subview: () -> UIView) {
        self.init()
        
        addSubview(subview())
    }
}
