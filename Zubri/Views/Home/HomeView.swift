//
//  HomeView.swift
//  Zubri
//
//  Created by Павел Сивак on 10/05/2025.
//

import SwiftUI

struct HomeView: View {
    
    @AppStorage("userName") private var userName = "Name"
    @StateObject private var viewModel = HomeViewModel(context: PersistenceController.shared.container.viewContext)

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundMainColor")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Text("Hi, \(userName)")
                                .font(
                                    .custom("Hanken Grotesk", size: 25))
                            
                            Text("Your streak: \(viewModel.currentStreak) day(s)!")
                                .font(.custom("Hanken Grotesk", size: 16).weight(.ultraLight))
                        }
                        
                        Spacer()
                        
                        Image("ZubrHome")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 160)
                            .offset(y: 22)
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Topics")
                            .font(.custom("Hanken Grotesk", size: 40))
                            .padding()
                        
                        ScrollView {
                            ForEach(viewModel.topics) { topic in
                                NavigationLink {
                                    SubtopicsView(topic: topic)
                                } label: {
                                    HStack(spacing: 10) {
                                        Text(topic.emojiSafe)
                                            .font(.system(size: 40, weight: .bold))
                                        
                                        Text(topic.titleSafe)
                                            .font(.custom("Hanken Grotesk", size: 22))
                                            .padding(.leading, 10)
                                    }
                                    .frame(width: 330, height: 70, alignment: .leading)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .background(Color("backgroundMainColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                    .padding(.horizontal)
                                    .padding(.top, 10)
                                }
                                
                            }
                        }
                    }
                    .background(Color(red: 0.95, green: 1, blue: 0.93))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
        }
    }
}

extension Topic {
    var titleSafe: String { title ?? "Untitled"}
    var emojiSafe: String { emoji ?? "📄" }
}

#Preview {
    HomeView()
}
