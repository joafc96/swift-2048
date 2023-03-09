//
//  TileValue.swift
//  swift-2048
//
//  Created by joe on 27/02/23.
//

import UIKit

protocol Evolvable: Equatable, CustomStringConvertible {
    init(score: Int)
    var score: Int { get }
    func evolve() -> Self?
    func getBgColor() -> UIColor
    static func getBaseValue() -> Self // returns the base value i.e Two
}

enum TileValue: Int, CaseIterable, Evolvable {
    case Two                                            = 2
    case Four                                           = 4
    case Eight                                          = 8
    case Sixteen                                        = 16
    case ThirtyTwo                                      = 32
    case SixtyFour                                      = 64
    case OneHundredAndTwentyEight                       = 128
    case TwoHundredAndFiftySix                          = 256
    case FiveHundredAndTwelve                           = 512
    case OneThousandAndTwentyFour                       = 1024
    case TwoThousandAndFourtyEight                      = 2048
    case FourThousandAndNinetySix                       = 4096
    case EightThousandOneHundredAndNinetyTwo            = 8192
    case SixteenThousandThreeHundredAndEightyFour       = 16384
    case ThirtyTwoThousandSevenHundredAndSixtyEight     = 32768
    case SixtyFiveThousandFiveHundredAndThirtySix       = 65536
    case OneHundredAndThirtyOneThousandAndSeventyTwo    = 131072
    
    init(score: Int) {
        assert(score % 2 == 0, "TileValue.init\(score): you must provide a score value which is divisible by 2")
        self = TileValue(rawValue: score)!
    }
    
    func evolve() -> TileValue? {
        switch self {
        case .Two:
            return .Four
        case .Four:
            return .Eight
        case .Eight:
            return .Sixteen
        case .Sixteen:
            return .ThirtyTwo
        case .ThirtyTwo:
            return .SixtyFour
        case .SixtyFour:
            return .OneHundredAndTwentyEight
        case .OneHundredAndTwentyEight:
            return .TwoHundredAndFiftySix
        case .TwoHundredAndFiftySix:
            return .FiveHundredAndTwelve
        case .FiveHundredAndTwelve:
            return .OneThousandAndTwentyFour
        case .OneThousandAndTwentyFour:
            return .TwoThousandAndFourtyEight
        case .TwoThousandAndFourtyEight:
            return .FourThousandAndNinetySix
        case .FourThousandAndNinetySix:
            return .EightThousandOneHundredAndNinetyTwo
        case .EightThousandOneHundredAndNinetyTwo:
            return .SixteenThousandThreeHundredAndEightyFour
        case .SixteenThousandThreeHundredAndEightyFour:
            return .ThirtyTwoThousandSevenHundredAndSixtyEight
        case .ThirtyTwoThousandSevenHundredAndSixtyEight:
            return .SixtyFiveThousandFiveHundredAndThirtySix
        case .SixtyFiveThousandFiveHundredAndThirtySix:
            return .OneHundredAndThirtyOneThousandAndSeventyTwo
        case .OneHundredAndThirtyOneThousandAndSeventyTwo:
            return nil
        }
    }
    
    func getBgColor() -> UIColor {
        switch self {
        case .Two:
            return ColorConstants.twoBG
        case .Four:
            return ColorConstants.fourBG
        case .Eight:
            return ColorConstants.eightBG
        case .Sixteen:
            return ColorConstants.sixteenBG
        case .ThirtyTwo:
            return ColorConstants.thirtyTwoBG
        case .SixtyFour:
            return ColorConstants.sixtyFourBG
        case .OneHundredAndTwentyEight:
            return ColorConstants.oneHundredAndTwentyEightBG
        case .TwoHundredAndFiftySix:
            return ColorConstants.twoHundredAndFiftySizBG
        case .FiveHundredAndTwelve:
            return ColorConstants.fiveHundredAndTwelveBG
        case .OneThousandAndTwentyFour:
            return ColorConstants.oneThousandAndTwentyFourBG
        case .TwoThousandAndFourtyEight:
            return ColorConstants.twoThousandAndFourtyEightBG
        case .FourThousandAndNinetySix:
            return ColorConstants.cellBG
        case .EightThousandOneHundredAndNinetyTwo:
            return ColorConstants.cellBG
        case .SixteenThousandThreeHundredAndEightyFour:
            return ColorConstants.cellBG
        case .ThirtyTwoThousandSevenHundredAndSixtyEight:
            return ColorConstants.cellBG
        case .SixtyFiveThousandFiveHundredAndThirtySix:
            return ColorConstants.cellBG
        case .OneHundredAndThirtyOneThousandAndSeventyTwo:
            return ColorConstants.cellBG
        }
    }
    
    static func getBaseValue() -> Self {
        return TileValue.Two
    }
    
    var score: Int {
        get {
            return self.rawValue
        }
    }
}

extension TileValue {
    var description: String {
        get {
            return "TileValue(\(self.rawValue))"
        }
    }
}
