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
    
    let animationDuration: Double = 1.0
    let delayBase: Double = 1.0
    
    deinit {
        print("GameCollectionViewProvider deinit")
    }
}


// MARK: - UICollectionViewDataSource
extension GameCollectionViewProvider: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dimension
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dimension
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.nameOfClass, for: indexPath) as! GameCollectionViewCell
        
        cell.alpha = 0
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameCollectionViewProvider: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfItemsInRow = dimension  //number of column you want according to total count
        
        let cellSpacing = 8
        
        // total - left and right - item spacing divided by no of items in row
        let size = Int((collectionView.frame.width - CGFloat((noOfItemsInRow - 1) * cellSpacing) - CGFloat(2 * cellSpacing) ) / CGFloat(noOfItemsInRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let delay = sqrt(Double(indexPath.row)) * delayBase
        UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseOut, animations: {
          cell.alpha = 1
        })
    }
}

// MARK: - UICollectionViewDelegate
extension GameCollectionViewProvider: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(self, withIndex: indexPath.row)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
