//
//  MainTabView.swift
//  Zubri
//
//  Created by Павел Сивак on 10/05/2025.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection: MainTab
    
    init(startWith tab: MainTab = .home) {
        _selection = State(initialValue: tab)
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                HomeView()
                    .tag(MainTab.home)
                    .tabItem { Label("", systemImage: "house") }
                
                ResultView()
                    .tag(MainTab.results)
                    .tabItem { Label("", systemImage: "text.page") }
                
                SettingsView()
                    .tag(MainTab.settings)
                    .tabItem { Label("", systemImage: "gear") }
            }
        }
        .tint(Color.black)
    }
}

enum MainTab: Hashable {
    case home, results, settings
}

#Preview {
    MainTabView()
}
