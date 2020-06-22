//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A modern `UICollectionViewCell` subclass.
open class UIXCollectionViewCell: UICollectionViewCell, UIXViewProtocol {
    public class var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private var isHeightCached: Bool = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
    
    override open func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard !isHeightCached else {
            return layoutAttributes
        }
        
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        
        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
        layoutAttributes.frame = newFrame
        
        isHeightCached = true
        
        return layoutAttributes
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        
        isHeightCached = true
    }
    
    open func didSelect() {
        
    }
    
    open func didDeselect() {
        
    }
}
