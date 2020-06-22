//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXModelTableView<CellModel, Cell: UIXModelTableViewCell<CellModel>>: UIXTableView {
    override open func setup() {
        register(Cell.self, forCellReuseIdentifier: String(describing: Cell.self))
        
        Cell.rowHeight.map({ rowHeight = $0 })
        Cell.estimatedRowHeight.map({ estimatedRowHeight = $0 })
    }
}
