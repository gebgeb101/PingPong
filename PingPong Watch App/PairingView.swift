//
//  PairingView.swift
//  PingPong
//
//  Created by Gabriella Sengkey on 29/07/25.
//

import SwiftUI

struct PairingView: View {
    let pairStatus = true //input logic of connectivity
    
    var body: some View {
        VStack {
            Text(pairStatus ? "Opponent found!" : "Searching for opponent...")
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
                                    
            Circle()
                .fill(Color.blue)
                .frame(width: 45, height: 45)
                .multilineTextAlignment(.center)
                .overlay {
                    Image(systemName: "antenna.radiowaves.left.and.right.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .multilineTextAlignment(.center)
            }
        }
        NavigationLink(destination: SelectTeamView()) {
        }
    }
}

#Preview {
    ContentView()
}
