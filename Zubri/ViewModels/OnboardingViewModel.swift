//
//  OnboardingViewModel.swift
//  Zubri
//
//  Created by Павел Сивак on 10/05/2025.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    
    func next() {
        if currentStep < 2 {
            currentStep += 1
        } else {
            UserDefaults.standard.set(true, forKey: "IsOnboardingCompleted")
        }
    }
}
