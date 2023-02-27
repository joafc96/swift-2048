//
//  MoveDirection.swift
//  swift-2048
//
//  Created by qbuser on 27/02/23.
//

import Foundation

enum MoveDirection: CustomStringConvertible {
    case Up
    case Down
    case Left
    case Right
    
    var description: String {
        get {
            switch self {
            case .Up:
                return "Up"
            case .Down:
                return "Down"
            case .Left:
                return "Left"
            case .Right:
                return "Right"
            }
        }
    }
}
