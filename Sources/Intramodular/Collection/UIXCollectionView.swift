//
// Copyright (c) Vatsal Manot.
//

import UIKit
import Swift

/// A modern `UICollectionView` subclass.
///
/// This subclass provides an intrinsic content size.
open class UIXCollectionView: UICollectionView, UIXViewProtocol, UICollectionViewDelegate {
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
        
        return .init(width: contentSize.width, height: height)
    }
    
    override open var isHidden: Bool {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        setup()
    }
    
    public convenience init() {
        self.init(collectionViewLayout: UICollectionViewLayout())
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// A customization point for subclasses.
    open func setup() {
        self.delegate = self
    }
    
    override open func reloadData() {
        super.reloadData()
        
        self.layoutIfNeeded()
        self.invalidateIntrinsicContentSize()
        
        if let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            switch collectionViewLayout.scrollDirection {
                case .horizontal:
                    isScrollEnabled = contentSize.width > width
                case .vertical:
                    isScrollEnabled = contentSize.height > height
                @unknown default:
                    break
            }
        }
    }
    
    // MARK: - Delegate -
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let centerCellIndexPath = centerCellIndexPath {
            collectionView(self, didSelectItemAt: centerCellIndexPath)
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let position = centerScrollPosition {
            collectionView.scrollToItem(at: indexPath, at: position, animated: true)
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Actions -
    
    public func scrollToCenterItem(animated: Bool = true) {
        guard let dataSource = dataSource else {
            return
        }
        
        guard dataSource.numberOfSections?(in: self) == nil else {
            return
        }
        
        let itemCount = dataSource.collectionView(self, numberOfItemsInSection: 0)
        
        if let position = centerScrollPosition {
            let indexPath = IndexPath(item: (itemCount != 0 ? itemCount : itemCount - 1) / 2, section: 0)
            
            scrollToItem(at: indexPath, at: position, animated: animated)
            
            collectionView(self, didSelectItemAt: indexPath)
        }
    }
}
