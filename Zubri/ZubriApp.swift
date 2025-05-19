//
//  ZubriApp.swift
//  Zubri
//
//  Created by Павел Сивак on 09/05/2025.
//

import SwiftUI

@main
struct ZubriApp: App {
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                MainTabView(startWith: .home)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                OnboardingView()
            }
        }
    }
}
