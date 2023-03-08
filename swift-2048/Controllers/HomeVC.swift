//
//  HomeVC.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCellForIndexPath(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.nameOfClass, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 4  //number of column you want according to total count
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
    
    private var viewModel: GameViewModel<HomeVC>
    
    // MARK: - Stored Properties
    private let gameView: GameView = GameView()
    
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
        
        
        gameView.collectionView.dataSource = self
        gameView.collectionView.delegate = self
    }
    
}


// conforms to the game delegate protocol and to its stubs.
extension HomeVC: GameDelegate {
    // provided typealias for the generic type T in game delegate.
    typealias T = TileValue
    
    func gameDidStart() {
        
    }
    
    func gameDidProduceActions(actions: [MoveAction<TileValue>]) {
        print(actions)
    }
    
    func gameDidUpdateValue(score: Int) {
        print("score: \(score)")
    }
    
    func gameDidUpdateValue(multiplier: Int) {
        print("mergeMultiplier: \(multiplier)")
        
    }
    
    func gameIsOver() {
        
    }
}
