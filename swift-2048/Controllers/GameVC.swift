//
//  HomeVC.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

class GameVC: UIViewController {
    
    // MARK: - Dependencies
    private var viewModel: GameViewModel<GameVC>
    
    // MARK: - Stored Properties
    private let gameView: GameView = GameView()
    private let gameCollectionViewProvider: GameCollectionViewProvider = GameCollectionViewProvider()
    
    let POP_ANIMATION_DURATION = 0.2


    // MARK: - Initializers
    init(viewModel: GameViewModel<GameVC>) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = gameView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.startGame()
    
        configureCollectionViewDelegates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.viewHasAppeared == false {
            viewModel.viewHasAppeared = true
            print("First Time")
            
            if viewModel.actionsToPerformOnAppearance.count > 0 {
                print("actionsToPerform")
                
                for action in viewModel.actionsToPerformOnAppearance {
                    
                    switch action {
                        
                    case .Spawn(tile: let tile):
                        
                        let indexPath = IndexPath(item: tile.position.x, section: tile.position.y)
                        let cell = gameView.collectionView.cellForItem(at: indexPath) as? GameCollectionViewCell
                        
                        UIView.animate(withDuration: self.POP_ANIMATION_DURATION, delay: 0.0, options: [.curveEaseOut] ,  animations: {
                            cell?.backgroundColor = tile.value.getBgColor()
                            cell?.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
                        }, completion: { _ in
                            cell?.transform = .identity
                            
                        })
                        
                        break
                    case .Move(from: let from, to: let to):
                        break
                    case .Merge(from: let from, andFrom: let andFrom, toTile: let toTile):
                        break
                    }
                    
                    
                }
                
                
//                self.gameBoardScene?.performMoveActions(actionsToPerformOnAppearance)
            }
        } else {
            print("Second Time")
        }
    }
    
    deinit {
        print("HomeVC deinit")
    }
    
}

// MARK: - GameCollectionViewProvider
extension GameVC: GameCollectionViewProviderDelegate {
    private func configureCollectionViewDelegates() {
        gameCollectionViewProvider.delegate = self
        
        gameView.collectionView.dataSource = gameCollectionViewProvider
        gameView.collectionView.delegate = gameCollectionViewProvider
    }
    
    func didSelectCell(_ provider: GameCollectionViewProvider, withIndex index: Int) {
        
    }
}


// MARK: - GameDelegate
extension GameVC: GameDelegate {

    // provided typealias for the generic type T in game delegate.
    typealias T = TileValue
    
    func gameDidStart(dimension: Int) {
        gameCollectionViewProvider.dimension = dimension
        gameView.collectionView.reloadData()
    }
    
    
    func gameDidProduceActions(actions: [MoveAction<TileValue>]) {
        if (viewModel.viewHasAppeared) {
            
        } else {
            for action in actions {
                viewModel.actionsToPerformOnAppearance.append(action)
            }
        }
    
    }
    
    func gameDidUpdateValue(score: Int) {
        print("score: \(score)")
    }
    
    func gameDidUpdateValue(multiplier: Int) {
        print("mergeMultiplier: \(multiplier)")
        
    }
    
    func gameDidEnd() {
        
    }
}
