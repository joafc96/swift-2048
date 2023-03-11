//
//  CellView.swift
//  swift-2048
//
//  Created by joe on 11/03/23.
//

import UIKit

class CellView: UIView {
    
    lazy var scoreLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.bold)
        lbl.textColor = UIColor(named: "cell")
        lbl.minimumScaleFactor = 0.4
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.clipsToBounds = true
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit() {
        backgroundColor =  UIColor(named: "cell")
        layer.cornerRadius = 4
        
        configureScoreLabel()
    }
    
 
    private func configureScoreLabel() {
        addSubview(scoreLabel)
        
        let scoreLblConstraints = [
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(scoreLblConstraints)
    }
}
