//
//  ContentView.swift
//  PingPong Watch App
//
//  Created by Muhammad Hafiz Siregar on 25/07/25.
//

import SwiftUI
import WatchKit

struct ContentView: View {
    var body: some View {
        VStack {
            VStack {
                Text("Let's Play")
                Text("PingPong Together")
            }
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            
            Image(.logoPP)
                .resizable().frame(width: 55, height: 50)
                .padding()
            
            NavigationLink(destination: PairingView()) {
                Text("Start")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(width: 180, height: 55)
                    .background(Color.white)
                    .cornerRadius(30)
            }
            .onTapGesture {
            }
        }
    }
}

#Preview {
    ContentView()
}
