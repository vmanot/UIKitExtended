//
// Copyright (c) Vatsal Manot
//

import QuartzCore
import Swift
import UIKit

extension UITableView {
    public var numberOfRows: Int {
        return (0..<numberOfSections)
            .reduce(into: 0, { $0 += numberOfRows(inSection: $1) })
    }
}

extension UITableView {
    public var visibleIndexPaths: [IndexPath] {
        return indexPathsForVisibleRows ?? []
    }
    
    public var visibleTopIndexPath: IndexPath? {
        if visibleIndexPaths.count <= 1 {
            return visibleIndexPaths.first
        } else {
            let firstPath = visibleIndexPaths[0]
            let secondPath = visibleIndexPaths[1]
            
            return rectForRow(at: firstPath).origin.y > contentOffset.y ? firstPath : secondPath
        }
        
    }
}

extension UITableView {
    public var selectedIndexPaths: [IndexPath] {
        return indexPathsForSelectedRows ?? []
    }
    
    public func selectRows(at indexPaths: [IndexPath], animated: Bool, scrollPosition: ScrollPosition = .none) {
        indexPaths.forEach {
            self.selectRow(at: $0, animated: animated, scrollPosition: scrollPosition)
        }
    }
    
    public func deselectAllRows(animated: Bool) {
        indexPathsForSelectedRows?.forEach {
            deselectRow(at: $0, animated: animated)
        }
    }
}

extension UITableView {
    public func setEditing(_ editing: Bool, animated: Bool, completion: (@escaping () -> Void)) {
        CATransaction.animationTransaction(
            { setEditing(editing, animated: animated) },
            completion: completion
        )
    }
}

extension UITableView {
    open func layoutTableHeaderView() {
        if let headerView = tableHeaderView {
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            headerView.frame.size.height = headerView
                .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
                .height
            
            tableHeaderView = headerView
        }
    }
    
    open func layoutTableFooterView() {
        if let footerView = tableFooterView {
            footerView.setNeedsLayout()
            footerView.layoutIfNeeded()
            
            footerView.frame.size.height = footerView
                .systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
                .height
            
            tableFooterView = footerView
        }
    }
}
