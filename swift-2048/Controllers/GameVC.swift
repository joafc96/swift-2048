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
        gameView.delegate = self
        
        viewModel.startGame()
    
        configureCollectionViewDelegates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if viewModel.viewHasAppeared == false {
            viewModel.viewHasAppeared = true
            print("First Time")
            if viewModel.actionsToPerformOnAppearance.count > 0 {
                self.gameView.performMoveActions(actions: viewModel.actionsToPerformOnAppearance)
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
        
        gameView.boardView.dataSource = gameCollectionViewProvider
        gameView.boardView.delegate = gameCollectionViewProvider
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
        gameView.boardView.reloadData()
    }
    
    
    func gameDidProduceActions(actions: [MoveAction<TileValue>]) {
        if (viewModel.viewHasAppeared) {
            gameView.performMoveActions(actions: actions)
        } else {
            for action in actions {
                viewModel.actionsToPerformOnAppearance.append(action)
            }
        }
    }
    
    func gameDidUpdateValue(score: Int) {
//        print("score: \(score)")
    }
    
    func gameDidUpdateValue(multiplier: Int) {
//        print("mergeMultiplier: \(multiplier)")
        
    }
    
    func gameDidEnd() {
        
    }
}


// MARK: - GameViewDelegate
extension GameVC: GameViewDelegate {
    func boardViewDidFinishAnimating() {
        print("didFinishAnimating")
        
    }
}
