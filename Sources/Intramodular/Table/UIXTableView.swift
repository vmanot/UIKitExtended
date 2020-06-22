//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

/// A modern `UITableView` subclass.
///
/// This subclass provides an intrinsic content size.
open class UIXTableView: UITableView, UIXViewProtocol {
    open override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        guard !isHidden else {
            return .zero
        }
        
        let height = 0
            + contentSize.height
            + contentInset.top
            + contentInset.bottom
        
        return .init(width: UIView.noIntrinsicMetric, height: height)
    }
    
    override open var isHidden: Bool {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public init(style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        
        estimatedRowHeight = UITableView.automaticDimension
        rowHeight = UITableView.automaticDimension
        
        setup()
    }
    
    public convenience init() {
        self.init(style: .plain)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        
    }
    
    open override func reloadData() {
        super.reloadData()
        
        self.layoutIfNeeded()
        self.invalidateIntrinsicContentSize()
    }
}
