//
//  FoodHubApp.swift
//  FoodHub
//
//  Created by Prince Shrivastav on 11/02/24.
//

import SwiftUI

@main
struct FoodHubApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
        }
        .onChange(of: scenePhase) { phase in
            // Handle scene phase changes if needed
        }
    }
}
