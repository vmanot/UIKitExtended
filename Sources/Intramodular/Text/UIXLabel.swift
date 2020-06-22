//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A modern `UILabel` subclass.
@IBDesignable
open class UIXLabel: UILabel, UIXViewProtocol {
    open var textInsets = UIEdgeInsets.zero {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        guard !isHidden else {
            return .zero
        }
        
        let intrinsicContentSize = super.intrinsicContentSize
        
        return .init(
            width: intrinsicContentSize.width + textInsets.horizontal,
            height: intrinsicContentSize.height + textInsets.vertical
        )
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
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
    
    override open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        return super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let sizeThatFits = super.sizeThatFits(size)
        
        return .init(
            width: sizeThatFits.width + textInsets.horizontal,
            height: sizeThatFits.height + textInsets.vertical
        )
    }
    
    override open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}

extension UIXLabel {
    public func setLineSpacing(
        _ lineSpacing: CGFloat = 0.0,
        lineHeightMultiple: CGFloat = 0.0
    ) {
        guard let text = text else {
            return
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString: NSMutableAttributedString
        
        if let attributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: attributedText)
        } else {
            attributedString = NSMutableAttributedString(string: text)
        }
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}
