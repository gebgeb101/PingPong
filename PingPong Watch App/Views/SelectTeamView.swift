//
//  SelectTeamView.swift
//  PingPong
//
//  Created by Gabriella Sengkey on 29/07/25.
//

import SwiftUI
import WatchKit

struct SelectTeamView: View {
    @StateObject private var gameManager = GameManager.shared
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("SELECT YOUR TEAM")
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .offset(y: -20)
                
                HStack(spacing: 10) {
                    
                    Button(action: {
                        gameManager.selectTeam(.red)
                    }) {
                        Text("TEAM RED")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 96, height: 130)
                            .background(Color.primaryRed)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        gameManager.selectTeam(.blue)
                    }) {
                        Text("TEAM BLUE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 96, height: 130)
                            .background(Color.primaryBlue)
                            .cornerRadius(10)
                    }
                    
                }
                NavigationLink(
                    destination: PlayingView(),
                    isActive: .constant(gameManager.gameState == .playing)
                ) {
                    EmptyView()
                }
                .buttonStyle(PlainButtonStyle())
            }
            .navigationTitle {
                Text ("Exit")
                    .font(.footnote)
                    .offset(x: -150, y: -20)
                    .foregroundColor(.blue)
            }
            .navigationBarBackButtonHidden(false) //native system will provide the chevron left arrow
        }
    }
}

#Preview {
    SelectTeamView()
}
