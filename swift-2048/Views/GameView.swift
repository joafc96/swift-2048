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
    
    
    lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)
        lbl.textColor = UIColor(named: "label")
        lbl.text = "2048"
        return lbl
    }()
    
    
    lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "Join the tiles, get to ", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .light),
            NSAttributedString.Key.foregroundColor: UIColor(named: "label")!,
        ])
        
        attributedText.append(NSAttributedString(string: "2048!", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor(named: "label")!,
        ]))
        
        lbl.attributedText = attributedText
        
        return lbl
    }()
    
    lazy var scoreLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.bold)
        lbl.textColor = UIColor(named: "label")
        lbl.textAlignment = .right
        lbl.alpha = 0.8
        lbl.text = "0"
        
        return lbl
    }()
    
    lazy var multiplierLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        lbl.textColor = UIColor(named: "label")
        lbl.textAlignment = .right
        lbl.alpha = 0.8
        lbl.text = "x0"
        
        return lbl
    }()
    
    lazy var statStackView: UIStackView = {
        let stkView = UIStackView()
        stkView.translatesAutoresizingMaskIntoConstraints = false
        stkView.axis = .horizontal
        stkView.alignment = .top
        
        return stkView
    }()
    
    
    lazy var howToPlayLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 5
        
        let attributedText = NSMutableAttributedString(string: "swipe", attributes: [
            NSAttributedString.Key.foregroundColor: UIColor(named: "label")!,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
        ])
        
        attributedText.append(NSAttributedString(string: " to move the tiles", attributes: [
            NSAttributedString.Key.foregroundColor:  UIColor(named: "label")!,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .light),
        ]))
        
        //        let attributedText = NSMutableAttributedString(string: "HOW TO PLAY: ", attributes: [
        //            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ])
        //
        //        attributedText.append(NSAttributedString(string: "Use your ", attributes: [
        //            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ]))
        //
        //        attributedText.append(NSAttributedString(string: "arrow keys ", attributes: [
        //            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ]))
        //
        //        attributedText.append(NSAttributedString(string: "to move the tiles. ", attributes: [
        //            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ]))
        //
        //        attributedText.append(NSAttributedString(string: "Tiles with the same number ", attributes: [
        //            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ]))
        //
        //        attributedText.append(NSAttributedString(string: "merge into one ", attributes: [
        //            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ]))
        //
        //        attributedText.append(NSAttributedString(string: "when they touch. ", attributes: [
        //            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ]))
        //
        //        attributedText.append(NSAttributedString(string: "Add them up to reach ", attributes: [
        //            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ]))
        //
        //        attributedText.append(NSAttributedString(string: "2048!", attributes: [
        //            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
        //            NSAttributedString.Key.foregroundColor: ColorConstants.tertiary,
        //        ]))
        lbl.attributedText = attributedText
        
        return lbl
    }()
    
    
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
        
        clnView.backgroundColor = UIColor(named: "grid")
        clnView.layer.cornerRadius = 4
        clnView.clipsToBounds = true
        
        return clnView
    }()
    
    override func layoutSubviews() {
        scoreLabel.sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(named: "background")
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
        addSubview(statStackView)
        addSubview(howToPlayLabel)
        
        statStackView.addArrangedSubview(scoreLabel)
        statStackView.addArrangedSubview(multiplierLabel)
        
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
            descriptionLabel.bottomAnchor.constraint(equalTo: statStackView.topAnchor, constant: -8)
        ]
        
        
        let statStackViewConstraints = [
            statStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            statStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            statStackView.bottomAnchor.constraint(equalTo: boardView.topAnchor, constant: -16)
        ]
        
        
        let clnViewConstraints = [
            boardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            boardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            boardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor),
            boardView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        
        let howToPlayConstraints = [
            howToPlayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            howToPlayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            howToPlayLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -54),
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(descConstraints)
        NSLayoutConstraint.activate(statStackViewConstraints)
        NSLayoutConstraint.activate(clnViewConstraints)
        NSLayoutConstraint.activate(howToPlayConstraints)
        
    }
    
}

// MARK: - Update Stats
extension GameView {
    func updateScore(score: Int) {
        guard let prevScore = scoreLabel.text else { return }
        let prevScoreInt = Int(prevScore)
        
        guard score != prevScoreInt else { return }
        
        scoreLabel.text = String(score)
        
        // change the transform property to provide a sliding in effect
        scoreLabel.transform = CGAffineTransform(translationX: 0, y: 25)
        scoreLabel.alpha = 0.1
        
        UIView.animate(withDuration: self.animationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: [.curveEaseInOut],
                       animations: {
            self.scoreLabel.alpha = 0.8
            self.scoreLabel.transform = .identity
        })
    }
    
    func updateMultiplier(multiplier: Int) {
        multiplierLabel.text = "x\(String(multiplier))"
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
        fromCell?.backgroundColor = UIColor(named: "cell")
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
        
        // update fromCell, andFromCell properties to default
        fromCell?.backgroundColor = UIColor(named: "cell")
        andFromCell?.backgroundColor = UIColor(named: "cell")
        fromCell?.scoreLabel.text = nil
        andFromCell?.scoreLabel.text = nil
        
        // update to toCell properties
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
        
        UIView.animate(withDuration: self.animationDuration, delay: 0.0, options: [.curveEaseOut], animations: {
            // update to cell position to its original position
            toCell?.layer.position = toCellPosition!
        })
    }
}
