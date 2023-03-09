//
//  GameCollectionViewCell.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    lazy var scoreLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.bold)
        lbl.textColor = ColorConstants.textDark
        lbl.minimumScaleFactor = 0.4
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
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
        addSubview(scoreLabel)
    }
    
    private func configureConstraints() {
        
        let scoreLblConstraints = [
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(scoreLblConstraints)
        
        
    }
    
}
