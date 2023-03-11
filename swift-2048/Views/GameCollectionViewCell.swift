//
//  GameCollectionViewCell.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  UIColor(named: "cell")
        view.layer.cornerRadius = 4
        
        return view
    }()
    
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
        backgroundColor =  UIColor(named: "cell")
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
        addSubview(cellView)
        cellView.addSubview(scoreLabel)
    }
    
    private func configureConstraints() {
        
        let cellViewConstraints = [
            cellView.widthAnchor.constraint(equalTo: widthAnchor),
            cellView.heightAnchor.constraint(equalTo: heightAnchor),
            
        ]
        
       
        
        let scoreLblConstraints = [
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(scoreLblConstraints)
        NSLayoutConstraint.activate(cellViewConstraints)
    }
}
