//
//  PairingView.swift
//  PingPong
//
//  Created by Gabriella Sengkey on 29/07/25.
//

import SwiftUI

struct PairingView: View {
    @StateObject private var gameManager = GameManager.shared
    
    var body: some View {
        VStack {
            Text(pairingStatusText)
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            Circle()
                .fill(gameManager.gameState == .found ? Color.green : Color.blue)
                .frame(width: 45, height: 45)
                .multilineTextAlignment(.center)
                .overlay {
                    Image(systemName: gameManager.gameState == .found ? "checkmark.circle.fill" : "antenna.radiowaves.left.and.right.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .multilineTextAlignment(.center)
                }
        }
        if gameManager.gameState == .found {
            NavigationLink(destination: SelectTeamView()) {
                Text("Continue")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: 120, height: 35)
                    .background(Color.white)
                    .cornerRadius(20)
            }
            .padding(.top)
        }
    }
    
    private var pairingStatusText: String {
        switch gameManager.gameState {
        case .searching:
            return "Searching for opponent..."
        case .found:
            return "Opponent found!\n\(gameManager.connectedPeerName ?? "Unknown Player")"
        default:
            return "Ready to play!"
        }
    }
}

#Preview {
    PairingView()
}
