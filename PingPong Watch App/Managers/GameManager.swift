//
//  GameManager.swift
//  PingPong Watch App
//
//  Created by Muhammad Hafiz Siregar on 30/07/25.
//

import Foundation
import WatchConnectivity
import WatchKit

class GameManager: NSObject, ObservableObject, WCSessionDelegate {
    static let shared = GameManager()
    
    @Published var gameState: GameState = .idle
    @Published var gameScore = GameScore()
    @Published var playerTeam: Team?
    @Published var opponentTeam: Team?
    @Published var isHost = false
    @Published var connectedPeerName: String?
    @Published var connectionStatus: String = "Disconnected"
    
    private var session: WCSession?
    
    override init() {
        super.init()
        setupWatchConnectivity()
    }
    
    // MARK: - WatchConnectivity Setup
    private func setupWatchConnectivity() {
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    // MARK: - Game Actions
    func startSearching() {
        gameState = .searching
        broadcastAvailability()
    }
    
    func selectTeam(_ team: Team) {
        playerTeam = team
        opponentTeam = team == .red ? .blue : .red
        
        sendMessage([
            "action": "teamSelected",
            "team": team.rawValue,
            "opponentTeam": opponentTeam?.rawValue ?? ""
        ])
        
        gameState = .playing
    }
    
    func updateScore(team: Team, increment: Bool) {
        guard gameState == .playing else { return }
        
        if team == .red {
            if increment {
                gameScore.redScore += 1
            } else if gameScore.redScore > 0 {
                gameScore.redScore -= 1
            }
        } else {
            if increment {
                gameScore.blueScore += 1
            } else if gameScore.blueScore > 0 {
                gameScore.blueScore -= 1
            }
        }
        
        // Check for set winner
        if let winner = gameScore.winner {
            handleSetWin(winner: winner)
        }
        
        // Sync score with opponent
        sendMessage([
            "action": "scoreUpdate",
            "redScore": gameScore.redScore,
            "blueScore": gameScore.blueScore,
            "redSets": gameScore.redSets,
            "blueSets": gameScore.blueSets
        ])
    }
    
    private func handleSetWin(winner: Team) {
        if winner == .red {
            gameScore.redSets += 1
        } else {
            gameScore.blueSets += 1
        }
        
        // Check for match winner
        if gameScore.matchWinner != nil {
            gameState = .gameOver
        } else {
            // Reset scores for next set
            gameScore.redScore = 0
            gameScore.blueScore = 0
            gameScore.currentSet += 1
        }
    }
    
    func resetGame() {
        gameScore = GameScore()
        playerTeam = nil
        opponentTeam = nil
        gameState = .idle
    }
    
    // MARK: - Communication
    private func broadcastAvailability() {
        sendMessage([
            "action": "searchingForOpponent",
            "deviceName": WKInterfaceDevice.current().name
        ])
    }
    
    private func sendMessage(_ message: [String: Any]) {
        guard let session = session, session.isReachable else { return }
        
        session.sendMessage(message, replyHandler: nil) { error in
            DispatchQueue.main.async {
                print("Error sending message: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            if activationState == .activated {
                print("Watch Connectivity activated")
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.handleReceivedMessage(message)
        }
    }
    
    private func handleReceivedMessage(_ message: [String: Any]) {
        guard let action = message["action"] as? String else { return }
        
        switch action {
        case "searchingForOpponent":
            if gameState == .searching {
                gameState = .found
                connectedPeerName = message["deviceName"] as? String
                isHost = true
                
                // Send response
                sendMessage([
                    "action": "opponentFound",
                    "deviceName": WKInterfaceDevice.current().name
                ])
            }
            
        case "opponentFound":
            if gameState == .searching {
                gameState = .found
                connectedPeerName = message["deviceName"] as? String
                isHost = false
            }
            
        case "teamSelected":
            if let teamString = message["team"] as? String,
               let opponentTeamString = message["opponentTeam"] as? String,
               let selectedTeam = Team(rawValue: teamString),
               let opponentSelectedTeam = Team(rawValue: opponentTeamString) {
                
                // Set opposite teams
                opponentTeam = selectedTeam
                playerTeam = opponentSelectedTeam
                gameState = .playing
            }
            
        case "scoreUpdate":
            if let redScore = message["redScore"] as? Int,
               let blueScore = message["blueScore"] as? Int,
               let redSets = message["redSets"] as? Int,
               let blueSets = message["blueSets"] as? Int {
                
                gameScore.redScore = redScore
                gameScore.blueScore = blueScore
                gameScore.redSets = redSets
                gameScore.blueSets = blueSets
                
                if gameScore.matchWinner != nil {
                    gameState = .gameOver
                }
            }
            
        default:
            break
        }
    }
}
