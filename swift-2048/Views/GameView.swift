//
//  GameView.swift
//  swift-2048
//
//  Created by qbuser on 08/03/23.
//

import UIKit

class GameView: UIView {
    fileprivate let sectionInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)

    
    lazy var collectionView: UICollectionView = {
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = sectionInsets
        flowLayout.minimumLineSpacing = sectionInsets.left
        flowLayout.minimumInteritemSpacing = sectionInsets.left
        
        let paddingSpace = Int(sectionInsets.left) * 5
        let availableWidth = Int(UIScreen.main.bounds.width) - paddingSpace
        let widthPerItem = availableWidth / 4
        
        flowLayout.itemSize = CGSize(
                width: widthPerItem,
                height: widthPerItem
            )
        let clnView = UICollectionView(
                frame: .zero,
                collectionViewLayout: flowLayout
            )
        clnView.translatesAutoresizingMaskIntoConstraints = false
        clnView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "GameViewCell")
            
        clnView.backgroundColor = UIColor(hex: 0xbbada0)
            
        return clnView
        
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        configureSubviews()
        configureConstraints()
    }
    
    private func configureSubviews() {
        
    }
    
    private func configureConstraints() {
        
    }
    
    
    


}
