//
//  GameCollectionViewProvider.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

protocol GameCollectionViewProviderDelegate: AnyObject {
    func didSelectCell(_ provider: GameCollectionViewProvider, withIndex index: Int)
}

final class GameCollectionViewProvider: NSObject {
    weak var delegate: GameCollectionViewProviderDelegate?
    
    var dimension: Int = 0
    var totalCount: Int = 0
    
    deinit {
        print("GameCollectionViewProvider deinit")
    }
}

extension GameCollectionViewProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.nameOfClass, for: indexPath) as! GameCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = dimension  //number of column you want according to total count
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalPaddingSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1)) // interItemSpacing will always be n - 1
        
        let size = Int((collectionView.bounds.width - totalPaddingSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
}


// MARK: - UICollectionViewDelegate
extension GameCollectionViewProvider: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(self, withIndex: indexPath.row)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
