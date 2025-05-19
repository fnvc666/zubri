//
//  SettingsViewModel.swift
//  Zubri
//
//  Created by Павел Сивак on 15/05/2025.
//

import Foundation
import SwiftUI
import CoreData

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var isOn = false
    @Published var nameTextColor = Color.black
    @Published var textFieldLocked = true
    @Published var showNameWarning = false
    @Published var showContactUsAlert = false
    @Published var showResetAppAlert = false
    @FocusState var isNameFocused: Bool
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
            self.context = context
    }

    
    func updateUserName(_ newName: String, setName: (String) -> Void) {
        if newName.count < 10 {
            setName(newName)
            nameTextColor = .black
            withAnimation {
                showNameWarning = false
            }
        } else {
            withAnimation {
                showNameWarning = true
            }
        }
    }
    
    func validateName(currentName: String) {
        if currentName.isEmpty {
            nameTextColor = .red
        } else {
            textFieldLocked = true
        }
    }
    
    func resetApp(results: FetchedResults<GameResult>,
                  clearName: () -> Void,
                    clearOnboarding: () -> Void) {
        clearName()
        clearOnboarding()
        
        results.forEach(context.delete)
        try? context.save()
    }
}
