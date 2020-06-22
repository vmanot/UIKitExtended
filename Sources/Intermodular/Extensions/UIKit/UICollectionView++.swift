//
// Copyright (c) Vatsal Manot
//

import Swift
import UIKit

extension UICollectionView {
    open var layoutScrollDirection: ScrollDirection? {
        if let collectionViewLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            return collectionViewLayout.scrollDirection
        } else {
            return nil
        }
    }
    
    open var centerScrollPosition: ScrollPosition? {
        guard let layoutScrollDirection = layoutScrollDirection else {
            return nil
        }
        
        switch layoutScrollDirection {
            case .horizontal:
                return .centeredHorizontally
            case .vertical:
                return .centeredVertically
            default:
                return nil
        }
    }
}

extension UICollectionView {
    open func cells(inSection section: Int) -> [UICollectionViewCell] {
        guard section < numberOfSections else {
            return []
        }
        
        var cells: [UICollectionViewCell] = []
        
        for item in 0..<numberOfItems(inSection: section) {
            guard let cell = cellForItem(at: IndexPath(item: item, section: section)) else {
                continue
            }
            
            cells.append(cell)
        }
        
        return cells
    }
    
    open func cell(where predicate: (UICollectionViewCell) -> Bool) -> UICollectionViewCell? {
        for section in 0..<numberOfSections {
            for item in 0..<numberOfItems(inSection: section) {
                guard let cell = cellForItem(at: IndexPath(item: item, section: section)) else {
                    continue
                }
                
                if predicate(cell) {
                    return cell
                }
            }
        }
        
        return nil
    }
    
    open func cell<T: UICollectionViewCell>(ofKind kind: T.Type) -> T? {
        cell(where: { $0.isKind(of: kind) }) as? T
    }
    
    open var selectedCells: [UICollectionViewCell] {
        (indexPathsForSelectedItems ?? [])
            .compactMap(cellForItem)
    }
    
    public var centerCellIndexPath: IndexPath? {
        indexPathForItem(at: CGPoint(x: self.center.x + contentOffset.x, y: center.y + contentOffset.y))
    }
    
    public var centerCell: UICollectionViewCell? {
        centerCellIndexPath.flatMap(cellForItem(at:))
    }
}
