//
//  GameEngine.swift
//  swift-2048
//
//  Created by qbuser on 27/02/23.
//

import Foundation

protocol GameEngineProtocol {
    associatedtype T: Evolvable
    
    var board: Array<Array<T?>> { get set }
    
    func moveLeft() -> [MoveAction<T>]
    func moveRight() -> [MoveAction<T>]
    func moveUp() -> [MoveAction<T>]
    func moveDown() -> [MoveAction<T>]
    func spawnNewTileAtRandomCoordinate() -> MoveAction<T>?
    func printBoard()
}


// T is TileValue as it confirms to the Evolvable protocol
class GameEngine<T: Evolvable>: GameEngineProtocol {
    
    // MARK: - Stored propeties
    let dimension: Int
    let threshold: T
    var board: Array<Array<T?>>
    
    // MARK: - Initializer
    init(dimension: Int, threshold: T) {
        self.dimension = dimension
        self.board = Array<Array<T?>>(repeating: Array(repeating: nil, count: dimension), count: dimension)
        self.threshold = threshold
    }
    
    // MARK: - Computed properties
    private var hasEmptySlot: Bool {
        for row in 0..<self.dimension {
            for col in 0..<self.dimension {
                if self.board[row][col] == nil { return true }
            }
        }
        return false
    }
    
    // MARK: - Left Configurations
    func moveLeft() -> [MoveAction<T>] {
        var actions = [MoveAction<T>]()
        
        for row in 0..<self.dimension {
            var prevSeenColIndex: Int?
            for col in 0..<self.dimension {
                
                if let currentEntry = self.board[row][col] {
                    // Entry is not nil
                    let currentCoordinate = Coordinate(x: row, y: col)
                    
                    if let prevColIndex = prevSeenColIndex {
                        // An entry was seen and was stored previously
                        let prevValCoordinate = Coordinate(x: row, y: prevColIndex)
                        
                        if currentEntry == self.board[row][prevColIndex] {
                            // MERGE. Prev entry and current entry are same.
                            let leftmostCoordinate  = self.getLeftMostCoordinateFrom(prevValCoordinate)
                            
                            self.mergeAndUpdateBoardHorizontally(toCoordinate: leftmostCoordinate,
                                                                 prevCoordinate: prevValCoordinate,
                                                                 currentCoordinate: currentCoordinate,
                                                                 currentEntry: currentEntry) { (moveAction: MoveAction<T>?) in
                                
                                if let moveAction = moveAction {
                                    actions.append(moveAction)
                                }
                            }
                            
                            // set the previously seen col index to nil as it is now merged and moved.
                            prevSeenColIndex = nil
                        } else {
                            // NO MERGE. Move the piece from prevCol to far left instead.
                            if let moveAction = moveTileAsFarLeftAsPossibleFromCurrent(prevValCoordinate) {
                                actions.append(moveAction)
                            }
                            
                            if col == self.dimension - 1 {
                                // No more pieces to try to merge with. Just move the last piece left.
                                if let moveAction = moveTileAsFarLeftAsPossibleFromCurrent(currentCoordinate) {
                                    actions.append(moveAction)
                                }
                            } else {
                                // Whatever was prev seen col index, did not result in a merge. Trying again with the current col.
                                prevSeenColIndex = col
                            }
                        }
                    } else {
                        
                        if col == self.dimension - 1 {
                            // Currently on the right edge. No need to store this to check for merging. Can just move it to th leftmost
                            if let moveAction = moveTileAsFarLeftAsPossibleFromCurrent(currentCoordinate) {
                                actions.append(moveAction)
                            }
                            
                        } else {
                            prevSeenColIndex = col
                        }
                    }
                    
                } else {
                    // No entry
                    if let prevColIndex = prevSeenColIndex {
                        if col == self.dimension - 1 {
                            // Currently at the right edge, so check if any previous value was seen or stored and if yes move it to the left
                            let prevCoordinate = Coordinate(x: row, y: prevColIndex)
                            if let moveAction = moveTileAsFarLeftAsPossibleFromCurrent(prevCoordinate) {
                                actions.append(moveAction)
                            }
                        }
                    }
                }
            }
            // Reassign it as nil to start a fresh row
            prevSeenColIndex = nil
        }
        
        return actions
    }
    
    private func moveTileAsFarLeftAsPossibleFromCurrent(_ coordinate: Coordinate)  -> MoveAction<T>?
    {
        var action: MoveAction<T>? = nil
        let leftmostCoordinate  = self.getLeftMostCoordinateFrom(coordinate)
        
        if leftmostCoordinate.y != coordinate.y {
            action = MoveAction.Move(from: coordinate, to: leftmostCoordinate)
            
            // update board
            self.board[coordinate.x][leftmostCoordinate.y] = self.board[coordinate.x][coordinate.y]
            self.board[coordinate.x][coordinate.y] = nil
        }
        return action
    }
    
    private func getLeftMostCoordinateFrom(_ coordinate: Coordinate) -> Coordinate
    {
        var leftmostCol = coordinate.y
        let currentRow = coordinate.x
        while (leftmostCol > 0 && self.board[currentRow][leftmostCol - 1] == nil) {
            leftmostCol -= 1
        }
        
        return Coordinate(x: currentRow, y: leftmostCol)
    }
    
    
    // MARK: - Right Configurations
    func moveRight() -> [MoveAction<T>] {
        var actions = [MoveAction<T>]()
        
        for row in 0..<self.dimension {
            var prevSeenColIndex: Int?
            for col in stride(from: self.dimension - 1, through: 0, by: -1) {
                
                if let currentEntry = self.board[row][col] {
                    let currentCoordinate = Coordinate(x: row, y: col)
                    
                    if let prevColIndex = prevSeenColIndex {
                        let prevValCoordinate = Coordinate(x: row, y: prevColIndex)
                        
                        if currentEntry == self.board[row][prevColIndex] {
                            //Merge
                            let rightmostCoordinate = self.getRightMostCoordinateFrom(prevValCoordinate)
                            
                            self.mergeAndUpdateBoardHorizontally(toCoordinate: rightmostCoordinate,
                                                                 prevCoordinate: prevValCoordinate,
                                                                 currentCoordinate: currentCoordinate,
                                                                 currentEntry: currentEntry) { (moveAction: MoveAction<T>?) in
                                
                                if let moveAction = moveAction {
                                    actions.append(moveAction)
                                }
                            }
                            
                            // set the previously seen col index to nil as it is now merged and moved
                            prevSeenColIndex = nil
                        } else {
                            // No Merge
                            if let action = self.moveTileAsFarRightAsPossibleFromCurrent(prevValCoordinate) {
                                actions.append(action)
                            }
                            
                            if col == 0 {
                                // No more pieces to try to merge with. Just move the last piece right.
                                if let action  = self.moveTileAsFarRightAsPossibleFromCurrent(currentCoordinate) {
                                    actions.append(action)
                                }
                            } else {
                                // Whatever was tempCol previously did not result in a merge. Trying again with the current col.
                                prevSeenColIndex = col
                            }
                        }
                    } else {
                        if col == 0 {
                            // Hit the left edge
                            if let action = self.moveTileAsFarRightAsPossibleFromCurrent(currentCoordinate) {
                                actions.append(action)
                            }
                        } else {
                            prevSeenColIndex = col
                        }
                    }
                    
                } else {
                    if let prevColIndex = prevSeenColIndex {
                        if col == 0 {
                            // Hit the left edge
                            let prevCoordinate = Coordinate(x: row, y: prevColIndex)
                            if let action = self.moveTileAsFarRightAsPossibleFromCurrent(prevCoordinate) {
                                actions.append(action)
                            }
                        }
                    }
                }
            }
            // Reassign it as nil to start a fresh row
            prevSeenColIndex = nil
        }
        
        return actions
    }
    
    
    private func moveTileAsFarRightAsPossibleFromCurrent(_ coordinate: Coordinate)  -> MoveAction<T>?
    {
        var action: MoveAction<T>? = nil
        let rightmostCoordinate  = self.getRightMostCoordinateFrom(coordinate)
        
        if rightmostCoordinate.y != coordinate.y {
            action = MoveAction.Move(from: coordinate, to: rightmostCoordinate)
            
            // update board
            self.board[coordinate.x][rightmostCoordinate.y] = self.board[coordinate.x][coordinate.y]
            self.board[coordinate.x][coordinate.y] = nil
        }
        return action
    }
    
    private func getRightMostCoordinateFrom(_ coordinate: Coordinate) -> Coordinate
    {
        var rightMostCol = coordinate.y
        let currentRow = coordinate.x
        while (rightMostCol < self.dimension - 1 && self.board[currentRow][rightMostCol + 1] == nil) {
            rightMostCol += 1
        }
        
        return Coordinate(x: currentRow, y: rightMostCol)
    }
    
    // MARK: - UP Configurations
    func moveUp() -> [MoveAction<T>] {
        var actions = [MoveAction<T>]()
        
        for col in 0..<self.dimension {
            var prevSeenRowIndex: Int?
            for row in 0..<self.dimension {
                
                if let currentEntry = self.board[row][col] {
                    let currentCoordinate = Coordinate(x: row, y: col)
                    
                    if let prevRowIndex = prevSeenRowIndex {
                        let prevValCoordinate = Coordinate(x: prevRowIndex, y: col)
                        
                        if currentEntry == self.board[prevRowIndex][col] {
                            // Merge
                            let topmostCoordinate = self.getTopMostCoordinateFrom(prevValCoordinate)
                            
                            self.mergeAndUpdateBoardVertically(toCoordinate: topmostCoordinate,
                                                               prevCoordinate: prevValCoordinate,
                                                               currentCoordinate: currentCoordinate,
                                                               currentEntry: currentEntry) { (moveAction: MoveAction<T>?) in
                                
                                if let action = moveAction {
                                    actions.append(action)
                                }
                            }
                            
                            // set the previously seen row index to nil as it is now merged and moved
                            prevSeenRowIndex = nil
                        } else {
                            // No Merge
                            // Move the previous value seen top cause no merge happened and is not needed for checking anymore.
                            if let action = self.moveTileAsFarTopAsPossibleFromCurrent(prevValCoordinate) {
                                actions.append(action)
                            }
                            
                            // if hit bottom move the current entry top, else update previous value seen index to current row
                            if row == self.dimension - 1 {
                                // Hit the bottom edge
                                if let action = self.moveTileAsFarTopAsPossibleFromCurrent(currentCoordinate){
                                    actions.append(action)
                                }
                                
                            } else {
                                prevSeenRowIndex = row
                            }
                        }
                    } else {
                        if row == self.dimension - 1 {
                            // Currently on the bottom edge. No need to store current entry to check for merging. Move it top.
                            if let action = self.moveTileAsFarTopAsPossibleFromCurrent(currentCoordinate){
                                actions.append(action)
                            }
                        } else {
                            prevSeenRowIndex = row
                        }
                    }
                } else {
                    //No current entry but a previous value exists, and the iterated row is the last. Move the previous value seen top.
                    
                    if let prevRowIndex = prevSeenRowIndex {
                        if row == self.dimension - 1 {
                            // Hit the bottom edge
                            
                            let prevValCoordinate = Coordinate(x: prevRowIndex, y: col)
                            if let action = self.moveTileAsFarTopAsPossibleFromCurrent(prevValCoordinate) {
                                actions.append(action)
                            }
                        }
                    }
                }
                
            }
            // Reassign it as nil to start a fresh row
            prevSeenRowIndex = nil
        }
        
        return actions
    }
    
    private func moveTileAsFarTopAsPossibleFromCurrent(_ coordinate: Coordinate)  -> MoveAction<T>?
    {
        var action: MoveAction<T>? = nil
        let topmostCoordinate  = self.getTopMostCoordinateFrom(coordinate)
        
        if topmostCoordinate.x != coordinate.x {
            action = MoveAction.Move(from: coordinate, to: topmostCoordinate)
            
            // update board
            self.board[topmostCoordinate.x][coordinate.y] = self.board[coordinate.x][coordinate.y]
            self.board[coordinate.x][coordinate.y] = nil
        }
        return action
    }
    
    private func getTopMostCoordinateFrom(_ coordinate: Coordinate) -> Coordinate
    {
        var topMostRow = coordinate.x
        let currentCol = coordinate.y
        while (topMostRow > 0 && self.board[topMostRow - 1][currentCol] == nil) {
            topMostRow -= 1
        }
        
        return Coordinate(x: topMostRow, y: currentCol)
    }
    
    // MARK: - Down Configurations
    func moveDown() -> [MoveAction<T>] {
        var actions = [MoveAction<T>]()
        
        for col in 0..<self.dimension {
            var prevSeenRowIndex: Int?
            for row in stride(from: self.dimension - 1, through: 0, by: -1) {
                
                if let currentEntry = self.board[row][col] {
                    let currentCoordinate = Coordinate(x: row, y: col)
                    
                    if let prevRowIndex = prevSeenRowIndex {
                        let prevValCoordinate = Coordinate(x: prevRowIndex, y: col)
                        
                        if currentEntry == self.board[prevRowIndex][col] {
                            let bottommostCoordinate = self.getBottomMostCoordinateFrom(prevValCoordinate)
                            
                            self.mergeAndUpdateBoardVertically(toCoordinate: bottommostCoordinate,
                                                               prevCoordinate: prevValCoordinate,
                                                               currentCoordinate: currentCoordinate,
                                                               currentEntry: currentEntry) { (moveAction: MoveAction<T>?) in
                                
                                if let action = moveAction {
                                    actions.append(action)
                                }
                            }
                            
                            // set the previously seen row index to nil as it is now merged and moved
                            prevSeenRowIndex = nil
                        } else {
                            //No merge
                            // Move the previous value seen bottom cause no merge happened and is not needed for checking anymore.
                            if let action = self.moveTileAsFarBottomAsPossibleFromCurrent(prevValCoordinate) {
                                actions.append(action)
                            }
                            
                            // if hit top move the current entry bottom, else update previous value seen index to current row
                            if row == 0 {
                                // Hit the top edge
                                if let action = self.moveTileAsFarBottomAsPossibleFromCurrent(currentCoordinate){
                                    actions.append(action)
                                }
                                
                            } else {
                                prevSeenRowIndex = row
                            }
                        }
                        
                    } else {
                        if row == 0 {
                            // Hit the top edge
                            // Currently on the top edge. No need to store current entry to check for merging. Move it bottom.
                            if let action = self.moveTileAsFarBottomAsPossibleFromCurrent(currentCoordinate) {
                                actions.append(action)
                            }
                        } else {
                            prevSeenRowIndex = row
                        }
                        
                    }
                } else {
                    //No current entry but a previous value exists, and the iterated row is the first. Move the previous value seen bottom.
                    if let prevRowIndex = prevSeenRowIndex {
                        if row == 0 {
                            // Hit the top edge
                            let prevValCoordinate = Coordinate(x: prevRowIndex, y: col)
                            if let action = self.moveTileAsFarBottomAsPossibleFromCurrent(prevValCoordinate){
                                actions.append(action)
                            }
                        }
                    }
                    
                }
            }
            prevSeenRowIndex = nil
        }
        
        return actions
    }
    
    
    private func moveTileAsFarBottomAsPossibleFromCurrent(_ coordinate: Coordinate)  -> MoveAction<T>?
    {
        var action: MoveAction<T>? = nil
        let bottommostCoordinate  = self.getBottomMostCoordinateFrom(coordinate)
        
        if bottommostCoordinate.x != coordinate.x {
            action = MoveAction.Move(from: coordinate, to: bottommostCoordinate)
            
            // update board
            self.board[bottommostCoordinate.x][coordinate.y] = self.board[coordinate.x][coordinate.y]
            self.board[coordinate.x][coordinate.y] = nil
        }
        return action
    }
    
    private func getBottomMostCoordinateFrom(_ coordinate: Coordinate) -> Coordinate
    {
        var bottomostRow = coordinate.x
        let currentCol = coordinate.y
        while (bottomostRow < self.dimension - 1 && self.board[bottomostRow + 1][currentCol] == nil) {
            bottomostRow += 1
        }
        
        return Coordinate(x: bottomostRow, y: currentCol)
    }
    
    
    // MARK: - Is Game Over
    func isGameOver() -> Bool {
        guard self.hasEmptySlot else { return false }
        
        // check if horizontal and vertical move are possible
        return isVerticalGameOver() && isHorizontalGameOver()
    }
    
    // MARK: - Spawn a new tile at random coordinate
    func spawnNewTileAtRandomCoordinate() -> MoveAction<T>? {
        var action: MoveAction<T>? = nil

        // if is not full continue to spawn a tile value
        guard self.hasEmptySlot else { return action }
        
        var emptySlots = [Coordinate]()
        
        for row in 0..<self.dimension {
            for col in 0..<self.dimension {
                if self.board[row][col] == nil {
                    emptySlots.append(Coordinate(x: row, y: col))
                }
            }
        }
        
        let randomCoordinateIndex = emptySlots.count.arc4random
        let randomSlot = emptySlots[randomCoordinateIndex]
        let baseValue = TileValue.getRandomValueOfTwoAndFour() as? T
        // assign random value of two or four to the randomly selected empty slot
        self.board[randomSlot.x][randomSlot.y] = baseValue
        
        // create a spawn action for the basevalue and random slot
        action = MoveAction.Spawn(tile: Tile(value: baseValue!, position: randomSlot))
                
        return action
    }
    
    // MARK: - Print Board
    func printBoard() {
        for row in 0..<self.dimension {
            var rowString = ""
            for col in 0..<self.dimension {
                if let entry = self.board[row][col] {
                    rowString += "\(entry.score) "
                } else {
                    rowString += "- "
                }
            }
            print(rowString)
            
        }
    }
    
    // -------------------------------
    // MARK: Private Helper Methods
    // -------------------------------
    
    private func mergeAndUpdateBoardHorizontally(toCoordinate: Coordinate,
                                                 prevCoordinate: Coordinate,
                                                 currentCoordinate: Coordinate,
                                                 currentEntry: T,
                                                 completion: (MoveAction<T>?) -> Void)
    {
        if let evolved = currentEntry.evolve() {
            // Create a MoveAction.Merge that have sources [row][prevCol] and [row][col] and ends up in [row][leftmost]/[row][rightMost]
            let newTile = Tile<T>(value: evolved, position: toCoordinate)
            let action = MoveAction.Merge(from: prevCoordinate,
                                          andFrom: currentCoordinate,
                                          toTile: newTile)
            completion(action)
        }
        
        // Update board
        // set the leftmost/rightmost tile to the evolved value and then current tile to nil.
        self.board[currentCoordinate.x][toCoordinate.y] = self.board[currentCoordinate.x][currentCoordinate.y]?.evolve()
        self.board[currentCoordinate.x][currentCoordinate.y] = nil
        
        // If we are on the leftMost/rightMost tile, we don't want to set this to nil, because we just set it to the evolved value 😋.
        if toCoordinate.y != prevCoordinate.y {
            self.board[currentCoordinate.x][prevCoordinate.y] = nil
        }
        
    }
    
    private func mergeAndUpdateBoardVertically(toCoordinate: Coordinate,
                                               prevCoordinate: Coordinate,
                                               currentCoordinate: Coordinate,
                                               currentEntry: T,
                                               completion: (MoveAction<T>?) -> Void)
    {
        if let evolved = currentEntry.evolve() {
            // Create a MoveAction.Merge that have sources [row][prevCol] and [row][col] and ends up in [topmostRow][col]/[downmostRow][col]
            let newTile = Tile<T>(value: evolved, position: toCoordinate)
            let action = MoveAction.Merge(from: prevCoordinate,
                                          andFrom: currentCoordinate,
                                          toTile: newTile)
            completion(action)
        }
        
        // Update board
        // set the topmost/downmost tile to the evolved value and then current tile to nil.
        self.board[toCoordinate.x][currentCoordinate.y] = self.board[currentCoordinate.x][currentCoordinate.y]?.evolve()
        self.board[currentCoordinate.x][currentCoordinate.y] = nil
        
        // If we are on the topmost/downmost tile, we don't want to set this to nil, because we just set it to the evolved value 😋.
        if toCoordinate.x != prevCoordinate.x {
            self.board[prevCoordinate.x][currentCoordinate.y] = nil
        }
        
    }
    
    // MARK: - Horizontal & Vertical Game Over Check
    private func isHorizontalGameOver() -> Bool {
        for row in 0..<self.dimension {
            for col in 0..<self.dimension - 1 {
                if self.board[row][col] == self.board[row][col + 1] { return false }
            }
        }
        
        return true
    }
    
    private func isVerticalGameOver() -> Bool {
        for col in 0..<self.dimension {
            for row in 0..<self.dimension - 1 {
                if self.board[row][col] == self.board[row + 1][col] { return false }
            }
        }
        
        return true
    }
}
