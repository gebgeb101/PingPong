//
//  PingPongApp.swift
//  PingPong Watch App
//
//  Created by Muhammad Hafiz Siregar on 25/07/25.
//

import SwiftUI

@main
struct PingPong_Watch_AppApp: App {
    
    init() {
        // Initialize WatchConnectivity when app launch
        _ = GameManager.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GameManager.shared)
        }
    }
}
