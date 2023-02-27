//
//  Tile.swift
//  swift-2048
//
//  Created by qbuser on 27/02/23.
//

import Foundation

struct Tile<T: Evolvable>: CustomStringConvertible {
    let value: T
    let position: Coordinate
    
    var description: String {
        get {
            return "Tile(value: \(value), position: \(position))"
        }
    }
}
