//
// Copyright (c) Vatsal Manot.
//

import Swift
import UIKit

public final class UIXModelCollectionViewDataSource<CellModel, Cell: UIXModelCollectionViewCell<CellModel>>: NSObject, UICollectionViewDataSource {
    public var data: [CellModel]
    
    public init(data: [CellModel]) {
        self.data = data
    }
    
    public subscript(_ indexPath: IndexPath) -> CellModel {
        return data[indexPath.item]
    }
    
    // MARK: UICollectionViewDataSource
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError()
        }
        
        cell.configure(with: self[indexPath])
        
        return cell
    }
}
