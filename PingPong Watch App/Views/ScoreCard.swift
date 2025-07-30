//
//  ScoreCard.swift
//  PingPong Watch App
//
//  Created by Muhammad Hafiz Siregar on 30/07/25.
//

import SwiftUI

struct ScoreCard: View {
    let team: Team
    let score: Int
    let isPlayerTeam: Bool
    let onScoreChange: (Bool) -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(team.color)
                .frame(width: 180, height: team == .red ? 90 : 70)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Text(team.displayName)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .padding(.leading, 20)
                    
                    if isPlayerTeam {
                        Image("LogoPP")
                            .resizable()
                            .frame(width: 10, height: 10)
                    }
                }
                
                HStack(spacing: 20) {
                    Button(action: {
                        onScoreChange(false)
                    }) {
                        Image(systemName: "minus")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .disabled(!isPlayerTeam)
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("\(score)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        onScoreChange(true)
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .disabled(!isPlayerTeam)
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ScoreCard(team: .red, score: 11, isPlayerTeam: true, onScoreChange: { _ in })
}
