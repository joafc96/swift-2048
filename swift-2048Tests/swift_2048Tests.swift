//
//  swift_2048Tests.swift
//  swift-2048Tests
//
//  Created by qbuser on 27/02/23.
//

import XCTest
@testable import swift_2048

final class swift_2048Tests: XCTestCase {
    
    var engine: TwoZeroFourEightEngine<TileValue>!
    let dimensions = 4

    override func setUpWithError() throws {
        engine = TwoZeroFourEightEngine<TileValue>(dimension: dimensions)
    }

    func testLeftMostColFromGivenCoordinateOfAnEmptyBoardisZero() {
        XCTAssert(getLeftMostColFromGivenCoordinateOfAnEmptyWith(coordinate: Coordinate(x: 3, y: 3)).y == 0, "getLeftMostColFrom.testLeftMostColFromGivenCoordinateOfAnEmptyBoardisZero: leftmost coordinate of given coorinate (3, 0) of an empty board should be zero.")
    }
    
    func getLeftMostColFromGivenCoordinateOfAnEmptyWith(coordinate: Coordinate) -> Coordinate{
        return engine.getLeftMostCoordinateFrom(coordinate)
    }
    
    func testMoveLeft() {
        engine.board[0][2] = TileValue.Two
        engine.board[0][3] = TileValue.Two
        engine.moveLeft()
        XCTAssert(engine.board[0][3] == nil)
        XCTAssert(engine.board[0][0] == TileValue.Four)
    }
    
    
    func testRightMostFromGivenCoordinateOfAnEmptyBoardisZero() {
        XCTAssert(getRightMostFromGivenCoordinateOfAnEmptyWith(coordinate: Coordinate(x: 1, y: 3)).y == (dimensions - 1))
    }
    
    func getRightMostFromGivenCoordinateOfAnEmptyWith(coordinate: Coordinate) -> Coordinate{
        return engine.getRightMostCoordinateFrom(coordinate)
    }
    
    func testMoveRight() {
        engine.board[0][1] = TileValue.Two
        engine.board[0][0] = TileValue.Two
        engine.moveRight()

        XCTAssert(engine.board[0][0] == nil)
        XCTAssert(engine.board[0][3] == TileValue.Four)
    }
    
    
    func testTopMostFromGivenCoordinateOfAnEmptyBoardisZero() {
        XCTAssert(getTopMostFromGivenCoordinateOfAnEmptyWith(coordinate: Coordinate(x: 3, y: 3)).x == 0)
    }
    
    func getTopMostFromGivenCoordinateOfAnEmptyWith(coordinate: Coordinate) -> Coordinate{
        return engine.getTopMostCoordinateFrom(coordinate)
    }
    
    func testMoveUp() {
        engine.board[2][1] = TileValue.Two
        engine.board[3][1] = TileValue.Two
        engine.moveUp()

        XCTAssert(engine.board[3][1] == nil)
        XCTAssert(engine.board[0][1] == TileValue.Four)
    }
    
    
    func testBottomMostFromGivenCoordinateOfAnEmptyBoardisZero() {
        XCTAssert(getBottomMostFromGivenCoordinateOfAnEmptyWith(coordinate: Coordinate(x: 3, y: 3)).x == (dimensions - 1))
    }
    
    func getBottomMostFromGivenCoordinateOfAnEmptyWith(coordinate: Coordinate) -> Coordinate{
        return engine.getBottomMostCoordinateFrom(coordinate)
    }
    
    func testMoveDown() {
        engine.board[0][1] = TileValue.Two
        engine.board[1][1] = TileValue.Two
        engine.moveDown()

        engine.printBoard()

        XCTAssert(engine.board[0][1] == nil)
        XCTAssert(engine.board[3][1] == TileValue.Four)
    }
    
    func testRandomMoves() {
        engine.board[0][1] = TileValue.Two
        engine.board[1][1] = TileValue.Two
        
        // move right
        engine.moveDown()
        
        // value of (0,1) merges with (1,1) and rests at (3,1)
        XCTAssert(engine.board[0][1] == nil)
        XCTAssert(engine.board[3][1] == TileValue.Four)
        
        // spawn a radom TileValue.Two at (3,0)
        engine.board[3][0] = TileValue.Two
        
        engine.moveLeft()
        
        // no change
        XCTAssert(engine.board[3][1] == TileValue.Four)
        XCTAssert(engine.board[3][0] == TileValue.Two)
        
        // spawn a radom TileValue.Two at (0,0)
        engine.board[0][0] = TileValue.Two
        
        engine.moveUp()
        
        // (3,1) -> (0,1) & (3,0) merges with (0,0) and rests at (0,0)
        XCTAssert(engine.board[0][1] == TileValue.Four)
        XCTAssert(engine.board[0][0] == TileValue.Four)
        
        // spawn a radom TileValue.Two at (2,0)
        engine.board[2][0] = TileValue.Two
        
        engine.moveRight()
        
        // (2,0) -> (2,3) & (0,0) merges with (0,1) and rests at (0,3)
        XCTAssert(engine.board[2][3] == TileValue.Two)
        XCTAssert(engine.board[0][3] == TileValue.Eight)
        
        engine.printBoard()
    }
    
    
    override func tearDownWithError() throws {
        engine = nil
    }

}
