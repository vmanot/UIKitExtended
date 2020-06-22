//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

open class UIXModelCollectionView<CellModel, Cell: UIXModelCollectionViewCell<CellModel>>: UIXCollectionView {
    private var _dataSource = UIXModelCollectionViewDataSource<CellModel, Cell>(data: [])
    
    override open func setup() {
        dataSource = _dataSource
        delegate = self
        
        register(Cell.self, forCellWithReuseIdentifier: Cell.reuseIdentifier)
    }
    
    public func configure(with data: [CellModel]) {
        _dataSource.data = data
        
        reloadData()
    }
    
    // MARK: UICollectionViewDelegate
    
    public var didSelectModel: ((CellModel) -> ())?
    public var didDeselectModel: ((CellModel) -> ())?
    
    override open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        
        didSelectModel?(_dataSource[indexPath])
        
        (cellForItem(at: indexPath) as? UIXCollectionViewCell)?.didSelect()
    }
    
    override open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didDeselectItemAt: indexPath)
        
        didDeselectModel?(_dataSource[indexPath])
        
        (cellForItem(at: indexPath) as? UIXCollectionViewCell)?.didDeselect()
    }
}

extension UIXModelCollectionView where CellModel: AnyObject {
    public func select(model: CellModel) {
        guard let index = _dataSource.data.firstIndex(where: { $0 === model }) else {
            return
        }
        
        selectItem(
            at: IndexPath(row: index, section: 0),
            animated: true,
            scrollPosition: ((collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection ?? .horizontal) == .horizontal ? .centeredHorizontally : .centeredVertically
        )
    }
}
