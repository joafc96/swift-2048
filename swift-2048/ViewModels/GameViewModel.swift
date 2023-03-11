//
//  GameViewModel.swift
//  swift-2048
//
//  Created by joe on 07/03/23.
//

import Foundation

// delegate method to be implemented by the controller
protocol GameDelegate: AnyObject {
    associatedtype T: Evolvable
    
    func gameDidStart(dimension: Int)
    func gameDidProduceActions(actions: [MoveAction<T>])
    func gameDidUpdateValue(score: Int)
    func gameDidUpdateValue(multiplier: Int)
    func gameDidEnd()
}


class GameViewModel<Delegate: GameDelegate>  where Delegate.T == TileValue {
    typealias D = TileValue

    private let dimension: Int
    private let threshold: D
    private let engine: GameEngine<D>
    
    private(set) var score: Int = 0 {
        didSet {
            delegate?.gameDidUpdateValue(score: score)
        }
    }
    
    private(set) var mergeMultiplier: Int = 0 {
        didSet {
            delegate?.gameDidUpdateValue(multiplier: mergeMultiplier)
        }
    }
    
    weak var delegate: Delegate?
    var viewHasAppeared: Bool = false
    var initialGameStateActions = [MoveAction<D>]()
    var actionsToPerformOnAppearance = [MoveAction<D>]()


    init(dimension: Int = 4, threshold: D = TileValue.TwoThousandAndFourtyEight){
        self.dimension = dimension
        self.threshold = threshold
        
        self.engine = GameEngine<D>(dimension: dimension, threshold: threshold)
    }
    
    deinit {
        print("GameViewModel deinit")
    }
}

// MARK: - Game Methods
extension GameViewModel {
    
    // MARK: - Start Game
    func startGame() {
        // nofy the game has created
        self.delegate?.gameDidStart(dimension: self.dimension)
        
        let firstSpawnAction = self.engine.spawnTileAtRandomCoordinate()
        let secondSpawnAction = self.engine.spawnTileAtRandomCoordinate()
        
        
        if let firstSpawnAction = firstSpawnAction {
            self.delegate?.gameDidProduceActions(actions: [firstSpawnAction])
        }
        
        if let secondSpawnAction = secondSpawnAction {
            self.delegate?.gameDidProduceActions(actions: [secondSpawnAction])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: { [weak self] in
            self?.moveInDirection(.Left)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: { [weak self] in
            self?.moveInDirection(.Up)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: { [weak self] in
            self?.moveInDirection(.Down)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6, execute: { [weak self] in
            self?.moveInDirection(.Right)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
            self?.moveInDirection(.Left)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4, execute: { [weak self] in
            self?.moveInDirection(.Down)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8, execute: { [weak self] in
            self?.moveInDirection(.Up)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2, execute: { [weak self] in
            self?.moveInDirection(.Right)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.6, execute: { [weak self] in
            self?.moveInDirection(.Down)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: { [weak self] in
            self?.moveInDirection(.Up)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.4, execute: { [weak self] in
            self?.moveInDirection(.Down)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.8, execute: { [weak self] in
            self?.moveInDirection(.Left)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.2, execute: { [weak self] in
            self?.moveInDirection(.Right)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.6, execute: { [weak self] in
            self?.moveInDirection(.Down)
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: { [weak self] in
            self?.moveInDirection(.Up)
        })
    }
    
    // MARK: - Move In Direction
    func moveInDirection(_ direction: MoveDirection) {
        let (scoreChange, actions) = self.engine.moveInDirection(direction)
        
        if actions.isEmpty {
            /*
             if no move or merge happens check if game is over.
             Notify through the delegates if game is over.
             (No actions will result in no spawning of new tile).
             */
            checkIsGameOver()
        } else {
            let spawnAction = self.engine.spawnTileAtRandomCoordinate()
            
            if let spawnAction = spawnAction {
                // Notify the produced actions (move || merge)
                self.delegate?.gameDidProduceActions(actions: actions)
                
                // Notify the spawned random tile
                self.delegate?.gameDidProduceActions(actions: [spawnAction])
                
                // update the total score
                // and score change on each swipe
                score += scoreChange
                mergeMultiplier = scoreChange
            }
            // after spawning a random tile check if is game over
                checkIsGameOver()
        }
        
    }
    
    func restartGame() {
        
    }
    
    
    private func checkIsGameOver() {
        let gameOver: Bool =   self.engine.isGameOver()
        
        if (gameOver) {
            self.delegate?.gameDidEnd()
        }
    }
}
