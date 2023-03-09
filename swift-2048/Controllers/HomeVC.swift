//
//  HomeVC.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

class HomeVC: UIViewController {
    
    private var viewModel: GameViewModel<HomeVC>
    
    // MARK: - Stored Properties
    private let gameView: GameView = GameView()
    private let gameCollectionViewProvider: GameCollectionViewProvider = GameCollectionViewProvider()

    // MARK: - Initializers
    init(viewModel: GameViewModel<HomeVC>) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    deinit {
        print("HomeVC deinit")
    }
    
}

// MARK: - GameCollectionViewProvider
extension HomeVC: GameCollectionViewProviderDelegate {
    private func configureCollectionViewDelegates() {
        gameCollectionViewProvider.delegate = self
        
        gameView.collectionView.dataSource = gameCollectionViewProvider
        gameView.collectionView.delegate = gameCollectionViewProvider
    }
    
    func didSelectCell(_ provider: GameCollectionViewProvider, withIndex index: Int) {
        
    }
}


// MARK: - GameDelegate
extension HomeVC: GameDelegate {

    // provided typealias for the generic type T in game delegate.
    typealias T = TileValue
    
    func gameDidStart(dimension: Int, totalCount: Int) {
        gameCollectionViewProvider.dimension = dimension
        gameCollectionViewProvider.totalCount = totalCount
        gameView.collectionView.reloadData()
    }
    
    
    func gameDidProduceActions(actions: [MoveAction<TileValue>]) {
    
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
