//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A modern `UITextView` subclass.
///
/// This subclass provides an intrinsic content size.
public class UIXTextView: UITextView, UIXViewProtocol {
    open var adjustsFontSizeToFitWidth: Bool = false
    
    public override var attributedText: NSAttributedString! {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override open var intrinsicContentSize: CGSize {
        guard !isHidden else {
            return .zero
        }
        
        return super.intrinsicContentSize
    }
    
    override open var isHidden: Bool {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public init() {
        super.init(frame: .zero, textContainer: nil)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        .init(width: size.width, height: textHeightForWidth(size.width))
    }
    
    override open func sizeFitting(width: CGFloat) -> CGSize {
        .init(width: width, height: textHeightForWidth(size.width))
    }
    
    override open func sizeFitting(height: CGFloat) -> CGSize {
        .init(width: textWidthForHeight(height), height: height)
    }
    
    override open func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        .init(width: size.width, height: textHeightForWidth(size.width))
    }
    
    open func adjustFontSizeToFitWidth() {
        guard !text.isEmpty && !bounds.size.equalTo(CGSize.zero) else {
            return
        }
        
        let textViewSize = frame.size;
        let fixedWidth = textViewSize.width;
        let expectSize = sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        if expectSize.height > textViewSize.height {
            while sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)).height > textViewSize.height {
                font = font!.withSize(font!.pointSize - 1)
            }
        } else {
            while sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)).height < textViewSize.height {
                font = font!.withSize(font!.pointSize + 1)
            }
        }
    }
}

// MARK: - Helpers -

extension UITextView {
    fileprivate func textHeightForWidth(_ width: CGFloat) -> CGFloat {
        let storage = NSTextStorage(attributedString: attributedText)
        let width = bounds.width - textContainerInset.horizontal
        let containerSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let container = NSTextContainer(size: containerSize)
        let manager = NSLayoutManager()
        
        manager.addTextContainer(container)
        storage.addLayoutManager(manager)
        container.lineFragmentPadding = textContainer.lineFragmentPadding
        container.lineBreakMode = textContainer.lineBreakMode
        _ = manager.glyphRange(for: container)
        
        return ceil(manager.usedRect(for: container).height + textContainerInset.vertical)
    }
    
    fileprivate func textWidthForHeight(_ height: CGFloat) -> CGFloat {
        let storage = NSTextStorage(attributedString: attributedText)
        let height = bounds.height - textContainerInset.vertical
        let containerSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let container = NSTextContainer(size: containerSize)
        let manager = NSLayoutManager()
        
        manager.addTextContainer(container)
        storage.addLayoutManager(manager)
        container.lineFragmentPadding = textContainer.lineFragmentPadding
        container.lineBreakMode = textContainer.lineBreakMode
        _ = manager.glyphRange(for: container)
        
        return ceil(manager.usedRect(for: container).width + textContainerInset.horizontal)
    }
}
