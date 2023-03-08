//
//  HomeVC.swift
//  swift-2048
//
//  Created by joe on 08/03/23.
//

import UIKit

class HomeVC: UIViewController {
    private var viewModel: GameViewModel<HomeVC>
    
    // MARK: - Initializers
    init(viewModel: GameViewModel<HomeVC>) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed

        viewModel.delegate = self
        viewModel.startGame()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
