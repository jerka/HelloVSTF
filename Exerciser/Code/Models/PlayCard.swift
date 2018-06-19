//
//  PlayCard.swift
//  Exerciser
//
//  Created by Markus Kruusmägi on 2018-06-19.
//  Copyright © 2018 GravelHill. All rights reserved.
//

import Foundation

enum Suit {
    case hearts
    case diamonds
    case clubs
    case spades
    
    var icon: String {
        switch self {
            case .hearts: return "♥️"
            case .diamonds: return "♦️"
            case .clubs: return "♣️"
            case .spades: return "♠️"
        }
    }
    
    static var allCases: [Suit] {
        return [.hearts, .diamonds, .clubs, .spades]
    }
}

enum Rank: Int, CustomStringConvertible {
    case ace = 1
    case two = 2
    case three = 3
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    
    static var allCases: [Rank] {
        return (1...13).map { Rank(rawValue: $0)! }
    }
   
    var description: String {
        switch self {
            case let x where x.rawValue >= 2 && x.rawValue <= 10:
                return "\(rawValue)"
            case .ace: return "A"
            
            case .jack: return "J"
            case .queen: return "Q"
            case .king: return "K"
        default:
            fatalError("Error! It's impossible!")
        }
    }
}

struct PlayCard: CustomStringConvertible {
    let rank: Rank
    let suit: Suit
    static var allCards: [PlayCard] {
        return Suit.allCases.flatMap { suit in
            Rank.allCases.map { rank in
                return PlayCard(rank: rank, suit: suit)
            }
        }
    }
        
    var description: String {
        return "\(rank.rawValue)\(suit.icon)"
    }
}


