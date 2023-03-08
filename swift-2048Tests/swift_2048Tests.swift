//
//  swift_2048Tests.swift
//  swift-2048Tests
//
//  Created by joe on 27/02/23.
//

import XCTest
@testable import swift_2048

final class swift_2048Tests: XCTestCase {
    
    var engine:  GameEngine<TileValue>!
    let dimensions = 4
    
    override func setUpWithError() throws {
        // Initialize the engine
        engine = GameEngine<TileValue>(dimension: dimensions, threshold: TileValue.TwoThousandAndFourtyEight)
    }
    
    
    func testMoveLeft() {
        engine.board[0][2] = TileValue.Two
        engine.board[0][3] = TileValue.Two
        let _ = engine.moveInDirection(.Left)
        
        XCTAssert(engine.board[0][3] == nil)
        XCTAssert(engine.board[0][0] == TileValue.Four)
    }
    
    
    
    func testMoveRight() {
        engine.board[0][1] = TileValue.Two
        engine.board[0][0] = TileValue.Two
        let _ = engine.moveInDirection(.Right)
        
        XCTAssert(engine.board[0][0] == nil)
        XCTAssert(engine.board[0][3] == TileValue.Four)
    }
    
    
    func testMoveUp() {
        engine.board[2][1] = TileValue.Two
        engine.board[3][1] = TileValue.Two
        let _ = engine.moveInDirection(.Up)
        
        XCTAssert(engine.board[3][1] == nil)
        XCTAssert(engine.board[0][1] == TileValue.Four)
    }
    
    func testMoveDown() {
        engine.board[0][1] = TileValue.Two
        engine.board[1][1] = TileValue.Two
        let _ = engine.moveInDirection(.Down)
        
        XCTAssert(engine.board[0][1] == nil)
        XCTAssert(engine.board[3][1] == TileValue.Four)
    }
    
    func testRandomMoves() {
        engine.board[0][1] = TileValue.Two
        engine.board[1][1] = TileValue.Two
        
        // move right
        let _ = engine.moveInDirection(.Down )
        
        // value of (0,1) merges with (1,1) and rests at (3,1)
        XCTAssert(engine.board[0][1] == nil)
        XCTAssert(engine.board[3][1] == TileValue.Four)
        
        // spawn a radom TileValue.Two at (3,0)
        engine.board[3][3] = TileValue.Two
        
        let _ = engine.moveInDirection(.Left)
        
        // no change
        XCTAssert(engine.board[3][0] == TileValue.Four)
        XCTAssert(engine.board[3][1] == TileValue.Two)
        
        // spawn a radom TileValue.Two at (0,0)
        engine.board[0][1] = TileValue.Two
        
        let _ = engine.moveInDirection(.Up)
        
        // (3,1) -> (0,1) & (3,0) merges with (0,0) and rests at (0,0)
        XCTAssert(engine.board[0][0] == TileValue.Four)
        XCTAssert(engine.board[0][1] == TileValue.Four)
        
        // spawn a radom TileValue.Two at (2,0)
        engine.board[2][0] = TileValue.Two
        
        let _ = engine.moveInDirection(.Right)
        
        // (2,0) -> (2,3) & (0,0) merges with (0,1) and rests at (0,3)
        XCTAssert(engine.board[2][3] == TileValue.Two)
        XCTAssert(engine.board[0][3] == TileValue.Eight)
        
    }
    
    
    func testRandomSpawn() {
        let firstSpawn = engine.spawnTileAtRandomCoordinate()
        
        XCTAssert(firstSpawn != nil)
    }
    
    func testScore() {
        var mainScore = 0
        
        engine.board[0][0] = TileValue.Two
        engine.board[0][1] = TileValue.Two
        engine.board[0][2] = TileValue.Two
        engine.board[0][3] = TileValue.Two
        
        let (score, _) = engine.moveInDirection(.Left) // score will be 8 (2+2, 2+2)
        mainScore += score
        
        let (newScore, _)  = engine.moveInDirection(.Left) // score will be 8 (4+4)
        mainScore += newScore
        
        
        XCTAssert(mainScore == 16)
    }
    
    override func tearDownWithError() throws {
        engine = nil
    }
    
}
