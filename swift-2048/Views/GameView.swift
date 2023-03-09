//
//  GameView.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

protocol GameViewDelegate: AnyObject {
    func boardViewDidFinishAnimating()
}

class GameView: UIView {
    typealias D = TileValue
    
    private let contentMargin: CGFloat = 20
    private let cellSpacing: CGFloat = 8
    private let POP_ANIMATION_DURATION = 0.2
//    private let SlIDE_ANIMATION_DURATION = 0.15

    weak var delegate: GameViewDelegate?

    lazy var boardView: UICollectionView = {
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                
        flowLayout.minimumLineSpacing = cellSpacing
        flowLayout.minimumInteritemSpacing = cellSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: 0, right: cellSpacing)
        
        let clnView = UICollectionView(
                frame: .zero,
                collectionViewLayout: flowLayout
            )
        
        clnView.translatesAutoresizingMaskIntoConstraints = false
        clnView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.nameOfClass)
            
        clnView.backgroundColor = ColorConstants.gridBG
        clnView.layer.cornerRadius = 4
        clnView.clipsToBounds = true
            
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
        addSubview(boardView)
    
    }
    
    private func configureConstraints() {
        
        let clnViewConstraints = [
            // Vertical
            boardView.centerYAnchor.constraint(equalTo: centerYAnchor),

            // Horizontal
            boardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor),
            boardView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(clnViewConstraints)

    }
    
    // MARK: - Perform Move Actions
    func performMoveActions(actions: [MoveAction<D>]) {
        for action in actions {
                switch action {
                    
                case .Spawn(tile: let tile):
                    print("spawn \(tile.position)")
                    let spawnIndexPath = IndexPath(item: tile.position.y, section: tile.position.x)
                    let spawnCell = boardView.cellForItem(at: spawnIndexPath) as? GameCollectionViewCell
                    
                    UIView.animate(withDuration: self.POP_ANIMATION_DURATION, delay: 0.0, options: [.curveEaseOut] ,  animations: {
                        spawnCell?.backgroundColor = tile.value.getBgColor()
                        spawnCell?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                    }, completion: { (doneAnimating: Bool) in
                        spawnCell?.transform = .identity
                    })
                    break
                    
                case .Move(from: let from, to: let to):
                    print("from \(from)")
                    print("to \(to)")
                    let fromIndexPath = IndexPath(item: from.y, section: from.x)
                    let toIndexPath = IndexPath(item: to.y, section: to.x)

                    let fromCell = boardView.cellForItem(at: fromIndexPath) as? GameCollectionViewCell
                    let toCell = boardView.cellForItem(at: toIndexPath) as? GameCollectionViewCell
                    
                    let tempColor = fromCell?.backgroundColor
                    fromCell?.backgroundColor = ColorConstants.cellBG
                    toCell?.backgroundColor = tempColor

                    break
                    
                case .Merge(from: let from, andFrom: let andFrom, toTile: let toTile):
                    print("from \(from)")
                    print("anFrom \(andFrom)")
                    let fromIndexPath = IndexPath(item: from.y, section: from.x)
                    let andFromIndexPath = IndexPath(item: andFrom.y, section: andFrom.x)
                    
                    let fromCell = boardView.cellForItem(at: fromIndexPath) as? GameCollectionViewCell
                    let andFromCell = boardView.cellForItem(at: andFromIndexPath) as? GameCollectionViewCell
                    
                    let toIndexPath = IndexPath(item: toTile.position.y, section: toTile.position.x)
                    let toCell = boardView.cellForItem(at: toIndexPath) as? GameCollectionViewCell
                    
                    fromCell?.backgroundColor = ColorConstants.cellBG
                    andFromCell?.backgroundColor = ColorConstants.cellBG
                    
                    UIView.animate(withDuration: self.POP_ANIMATION_DURATION, delay: 0.0, options: [.curveEaseOut] ,  animations: {
                        toCell?.backgroundColor = toTile.value.getBgColor()
                        toCell?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                    }, completion: { (doneAnimating: Bool) in
                        toCell?.transform = .identity
                    })
                    break
                }
        }
        
            self.delegate?.boardViewDidFinishAnimating()
        
    }
    
}
