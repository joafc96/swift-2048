//
//  GameCollectionViewCell.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorConstants.cellBG
        layer.cornerRadius = 4
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
    }
    
    private func commonInit() {
        configureSubViews()
        configureConstraints()
    }
    
    private func configureSubViews() {
    }
    
    private func configureConstraints() {
    }
    
}
