//
//  Untitled.swift
//  PingPong
//
//  Created by Muhammad Hafiz Siregar on 30/07/25.
//

import SwiftUI
import WatchConnectivity

enum Team: String, CaseIterable {
    case red = "red"
    case blue = "blue"
    
    var displayName: String {
        switch self {
        case .red: return "Team Red"
        case .blue: return "Team Blue"
        }
    }
    
    var color: Color {
        switch self {
        case .red: return .primaryRed
        case .blue: return .primaryBlue
        }
    }
}

enum GameState {
    case idle
    case searching
    case found
    case teamSelection
    case playing
    case gameOver
}

struct GameScore {
    var redScore: Int = 0
    var blueScore: Int = 0
    var redSets: Int = 0
    var blueSets: Int = 0
    var currentSet: Int = 1
    
    var isGamePoint: Bool {
        return (redScore >= 10 && redScore - blueScore >= 1) ||
               (blueScore >= 10 && blueScore - redScore >= 1)
    }
    
    var winner: Team? {
        if redScore >= 11 && redScore - blueScore >= 2 {
            return .red
        } else if blueScore >= 11 && blueScore - redScore >= 2 {
            return .blue
        }
        return nil
    }
    
    var matchWinner: Team? {
        if redSets >= 2 { return .red }
        if blueSets >= 2 { return .blue }
        return nil
    }
}
