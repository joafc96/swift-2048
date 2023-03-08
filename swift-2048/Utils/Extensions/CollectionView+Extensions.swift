//
//  CollectionView+Extensions.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCellForIndexPath<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.nameOfClass, for: indexPath) as! T
    }
}
