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
    
    private let cellSpacing: CGFloat = 8
    private let animationDuration = 0.2
    
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
    
    lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "Join the tiles, get to ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: ColorConstants.cellBG])
        
        attributedText.append(NSAttributedString(string: "2048!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: ColorConstants.cellBG]))
        
        lbl.attributedText = attributedText
        
        return lbl
    }()
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.bold)
        lbl.textColor = ColorConstants.cellBG
        lbl.text = "2048"
        return lbl
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
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(boardView)
        
    }
    
    private func configureConstraints() {
        
        let titleConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -8)
        ]
        
        let descConstraints = [
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            descriptionLabel.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -16)
        ]
        
        
        let clnViewConstraints = [
            // Vertical
            boardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Horizontal
            boardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            boardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor),
            boardView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(descConstraints)
        NSLayoutConstraint.activate(clnViewConstraints)



        
    }
    
}


// MARK: - Move Actions
extension GameView {
    
    // MARK: - Perform Move Actions
    func performMoveActions(actions: [MoveAction<D>]) {
        for action in actions {
            switch action {
            case .Spawn(tile: let tile):
                spawn(tile: tile)
                break
                
            case .Move(from: let from, to: let to):
                move(from: from, to: to)
                break
                
            case .Merge(from: let from, andFrom: let andFrom, toTile: let toTile):
                merge(from: from, andFrom: andFrom, toTile: toTile)
                break
            }
        }
    }
    
    // MARK: - private Individual Action Methods
    private func move(from: Coordinate, to: Coordinate) {
        let fromIndexPath = IndexPath(item: from.y, section: from.x)
        let toIndexPath = IndexPath(item: to.y, section: to.x)
        
        let fromCell = boardView.cellForItem(at: fromIndexPath) as? GameCollectionViewCell
        let toCell = boardView.cellForItem(at: toIndexPath) as? GameCollectionViewCell
        
        //keep a copy of the fromCell properties to update with the toCell properties
        let fromCellColor = fromCell?.backgroundColor
        let fromCellScore = fromCell?.scoreLabel.text
        
        //update fromCell properties to default
        fromCell?.backgroundColor = ColorConstants.cellBG
        fromCell?.scoreLabel.text = nil
        
        // update the toCell properties with fromCell properties
        toCell?.backgroundColor = fromCellColor
        toCell?.scoreLabel.text = fromCellScore
        
        executeMoveAnimation(toCell: toCell, fromCell: fromCell)
    }
    
    private func merge(from: Coordinate, andFrom: Coordinate, toTile: Tile<D>) {
        let fromIndexPath = IndexPath(item: from.y, section: from.x)
        let andFromIndexPath = IndexPath(item: andFrom.y, section: andFrom.x)
        
        let fromCell = boardView.cellForItem(at: fromIndexPath) as? GameCollectionViewCell
        let andFromCell = boardView.cellForItem(at: andFromIndexPath) as? GameCollectionViewCell
        
        let toIndexPath = IndexPath(item: toTile.position.y, section: toTile.position.x)
        let toCell = boardView.cellForItem(at: toIndexPath) as? GameCollectionViewCell
        
        // update fromCell, andFromCell values to default
        fromCell?.backgroundColor = ColorConstants.cellBG
        andFromCell?.backgroundColor = ColorConstants.cellBG
        fromCell?.scoreLabel.text = nil
        andFromCell?.scoreLabel.text = nil
        
        // update to toCell values
        toCell?.backgroundColor = toTile.value.getBgColor()
        toCell?.scoreLabel.text = String(toTile.value.score)
        
        executeMoveAnimation(toCell: toCell, fromCell: fromCell)
    }
    
    private func spawn(tile: Tile<D>) {
        print("spawn: \(tile)")
        let spawnIndexPath = IndexPath(item: tile.position.y, section: tile.position.x)
        let spawnCell = boardView.cellForItem(at: spawnIndexPath) as? GameCollectionViewCell
        
        // update the spawnCell properties
        spawnCell?.backgroundColor = tile.value.getBgColor()
        spawnCell?.scoreLabel.text = String(tile.value.score)
        
        executeSpawnAnimation(spawnCell: spawnCell)
    }
    
    private func executeSpawnAnimation(spawnCell: GameCollectionViewCell?) {
        spawnCell?.alpha = 0.1
        spawnCell?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1).concatenating(CGAffineTransform(rotationAngle: 3.14))
        
        UIView.animate(withDuration: self.animationDuration, delay: 0.0, options: [.curveEaseOut] ,  animations: {
            spawnCell?.alpha = 1.0
            spawnCell?.transform = .identity
        }, completion: { _ in
            self.delegate?.boardViewDidFinishAnimating()
        })
    }
    
    private func executeMoveAnimation(toCell: GameCollectionViewCell?, fromCell: GameCollectionViewCell?) {
        /* create a temp copy of to cell position and now,
         update toCell position to the fromCell position (so to create the translation effect).
         */
        let toCellPosition = toCell?.layer.position
        toCell?.layer.position = (fromCell?.layer.position)!
        
        UIView.animate(withDuration: self.animationDuration, delay: 0.0,options: [.curveEaseOut], animations: {
            // update to cell position to its original position
            toCell?.layer.position = toCellPosition!
        })
    }
}
