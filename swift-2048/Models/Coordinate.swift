//
//  Coordinate.swift
//  swift-2048
//
//  Created by qbuser on 27/02/23.
//

import Foundation

struct Coordinate: Equatable, CustomStringConvertible {
    let x: Int
    let y: Int
    
    var description: String {
        get {
            return "Coordinate(x: \(x), y: \(y))"
        }
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}
