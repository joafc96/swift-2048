//
//  swift_2048Tests.swift
//  swift-2048Tests
//
//  Created by qbuser on 27/02/23.
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
        let _ = engine.moveLeft()
        
        XCTAssert(engine.board[0][3] == nil)
        XCTAssert(engine.board[0][0] == TileValue.Four)
    }
    

    
    func testMoveRight() {
        engine.board[0][1] = TileValue.Two
        engine.board[0][0] = TileValue.Two
        let _ = engine.moveRight()
        
        XCTAssert(engine.board[0][0] == nil)
        XCTAssert(engine.board[0][3] == TileValue.Four)
    }
    
    
    func testMoveUp() {
        engine.board[2][1] = TileValue.Two
        engine.board[3][1] = TileValue.Two
        let _ = engine.moveUp()
        
        XCTAssert(engine.board[3][1] == nil)
        XCTAssert(engine.board[0][1] == TileValue.Four)
    }
    
    func testMoveDown() {
        engine.board[0][1] = TileValue.Two
        engine.board[1][1] = TileValue.Two
        let _ = engine.moveDown()
                
        XCTAssert(engine.board[0][1] == nil)
        XCTAssert(engine.board[3][1] == TileValue.Four)
    }
    
    func testRandomMoves() {
        engine.board[0][1] = TileValue.Two
        engine.board[1][1] = TileValue.Two
        
        // move right
        let _ = engine.moveDown()
        
        // value of (0,1) merges with (1,1) and rests at (3,1)
        XCTAssert(engine.board[0][1] == nil)
        XCTAssert(engine.board[3][1] == TileValue.Four)
        
        // spawn a radom TileValue.Two at (3,0)
        engine.board[3][3] = TileValue.Two
        
        let _ = engine.moveLeft()
    
        // no change
        XCTAssert(engine.board[3][0] == TileValue.Four)
        XCTAssert(engine.board[3][1] == TileValue.Two)
        
        // spawn a radom TileValue.Two at (0,0)
        engine.board[0][1] = TileValue.Two
        
        let _ = engine.moveUp()
        
        // (3,1) -> (0,1) & (3,0) merges with (0,0) and rests at (0,0)
        XCTAssert(engine.board[0][0] == TileValue.Four)
        XCTAssert(engine.board[0][1] == TileValue.Four)
        
        // spawn a radom TileValue.Two at (2,0)
        engine.board[2][0] = TileValue.Two
        
        let _ = engine.moveRight()
        
        // (2,0) -> (2,3) & (0,0) merges with (0,1) and rests at (0,3)
        XCTAssert(engine.board[2][3] == TileValue.Two)
        XCTAssert(engine.board[0][3] == TileValue.Eight)
                
    }
    
    func testRandomSpawn() {
        let firstSpawn = engine.spawnNewTileAtRandomCoordinate()

        XCTAssert(firstSpawn != nil)
    }
    
    
    override func tearDownWithError() throws {
        engine = nil
    }
    
}
