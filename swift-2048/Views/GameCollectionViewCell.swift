//
//  GameCollectionViewCell.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    lazy var cellView: CellView = {
        let view = CellView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    private func commonInit() {
        configureCellView()
    }
    
    private func configureCellView() {
        addSubview(cellView)
        let cellViewConstraints = [
            cellView.heightAnchor.constraint(equalTo: heightAnchor),
            cellView.widthAnchor.constraint(equalTo: widthAnchor),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]

        NSLayoutConstraint.activate(cellViewConstraints)
    }
}
