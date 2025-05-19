//
//  StreakManager.swift
//  Zubri
//
//  Created by Павел Сивак on 15/05/2025.
//

import Foundation

class StreakManager: ObservableObject {
    @Published var currentStreak: Int = 1
    
    private let calendar = Calendar.current
    private let streakKey = "currentStreak"
    private let lastOpenedKey = "lastOpenedDate"
    
    init() {
        checkStreak()
    }
    
    func checkStreak() {
        let today = calendar.startOfDay(for: Date())
        let defaults = UserDefaults.standard
        
        guard let lastDate = defaults.object(forKey: lastOpenedKey) as? Date else {
            currentStreak = 1
            defaults.set(currentStreak, forKey: streakKey)
            defaults.set(today, forKey: lastOpenedKey)
            return
        }
        
        let lastStartDay = calendar.startOfDay(for: lastDate)
        let daysBetween = calendar.dateComponents([.day], from: lastStartDay, to: today).day ?? 0
        
        switch daysBetween {
        case 0:
            currentStreak = max(defaults.integer(forKey: streakKey), 1)
        case 1:
            currentStreak = defaults.integer(forKey: streakKey) + 1
        default:
            currentStreak = 1
        }

        defaults.set(currentStreak, forKey: streakKey)
        defaults.set(today, forKey: lastOpenedKey)
    }

}
