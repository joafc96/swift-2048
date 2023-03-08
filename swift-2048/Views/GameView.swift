//
//  GameView.swift
//  swift-2048
//
//  Created by qbuser on 08/03/23.
//

import UIKit

class GameView: UIView {
    private let contentMargin: CGFloat = 20
    private let cellSpacing: CGFloat = 8

    lazy var collectionView: UICollectionView = {
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                
        flowLayout.minimumLineSpacing = cellSpacing
        flowLayout.minimumInteritemSpacing = cellSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        
        let clnView = UICollectionView(
                frame: .zero,
                collectionViewLayout: flowLayout
            )
        
        clnView.translatesAutoresizingMaskIntoConstraints = false
        clnView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.nameOfClass)
            
        clnView.backgroundColor = ColorConstants.gridBG
            
        return clnView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorConstants.mainBG
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
        
        addSubview(collectionView)
    
        
    }
    
    private func configureConstraints() {
        
        let clnViewConstraints = [
            // Vertical
            collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),

            // Horizontal
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: contentMargin),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -contentMargin),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(clnViewConstraints)

    }
    
    
    


}
