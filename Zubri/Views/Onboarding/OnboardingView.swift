//
//  OnboardingView.swift
//  Zubri
//
//  Created by Павел Сивак on 10/05/2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    var body: some View {
        ZStack {
            Color("backgroundMainColor")
                .ignoresSafeArea()
            TabView {
                Onboarding1View()
                Onboarding2View()
                Onboarding3View()
                Onboarding4View()
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

#Preview {
    OnboardingView()
}
