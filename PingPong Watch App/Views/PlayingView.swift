//
//  PlayingView.swift
//  PingPong
//
//  Created by Gabriella Sengkey on 28/07/25.
//

import SwiftUI
import WatchKit

struct PlayingView: View {
    @StateObject private var gameManager = GameManager.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                // Top team (player's team or red by default)
                ScoreCard(
                    team: topTeam,
                    score: topScore,
                    isPlayerTeam: topTeam == gameManager.playerTeam,
                    onScoreChange: { increment in
                        gameManager.updateScore(team: topTeam, increment: increment)
                    }
                )
                
                // Set scores
                HStack {
                    Text("\(gameManager.gameScore.redSets)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryRed)
                    
                    Text("vs")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("\(gameManager.gameScore.blueSets)")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryBlue)
                }
                .multilineTextAlignment(.center)

                // Bottom team
                ScoreCard(
                    team: bottomTeam,
                    score: bottomScore,
                    isPlayerTeam: bottomTeam == gameManager.playerTeam,
                    onScoreChange: { increment in
                        gameManager.updateScore(team: bottomTeam, increment: increment)
                    }
                )
            }
            .navigationTitle {
                Text ("Rematch")
                    .font(.footnote)
                    .offset(x: -100, y: -20)
                    .foregroundColor(.blue)
            }
            .navigationBarBackButtonHidden(false)
            .alert("Game Over!", isPresented: .constant(gameManager.gameState == .gameOver)) {
                Button("New Game") {
                    gameManager.resetGame()
                }
            } message: {
                if let winner = gameManager.gameScore.matchWinner {
                    Text("\(winner.displayName) wins the match!")
                }
            }
        }
    }
    
    private var topTeam: Team {
        return gameManager.playerTeam == .red ? .red : .blue
    }
    
    private var bottomTeam: Team {
        return gameManager.playerTeam == .red ? .blue : .red
    }
    
    private var topScore: Int {
        return topTeam == .red ? gameManager.gameScore.redScore : gameManager.gameScore.blueScore
    }
    
    private var bottomScore: Int {
        return bottomTeam == .red ? gameManager.gameScore.redScore : gameManager.gameScore.blueScore
    }
}

#Preview {
    PlayingView()
        
}
