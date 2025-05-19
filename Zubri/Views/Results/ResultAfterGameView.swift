//
//  ResultView.swift
//  Zubri
//
//  Created by Павел Сивак on 10/05/2025.
//

import SwiftUI
import CoreData

struct ResultAfterGameView: View {
    
    private let subtopic: Subtopic
    private let correct: Int
    private let total: Int
    
    @StateObject private var viewModel: ResultAfterGameViewModel
    
    init(subtopic: Subtopic, correct: Int, total: Int, context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.subtopic = subtopic
        self.correct = correct
        self.total = total
        
        _viewModel = StateObject(wrappedValue: ResultAfterGameViewModel(subtopic: subtopic, correct: correct, total: total, context: context))
    }
    
    var body: some View {
        ZStack {
            Color("backgroundMainColor")
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text(viewModel.resultPhrase.text)
                    .font(.custom("Hanken Grotesk", size: 40))
                    .padding(.top)
                
                Image(viewModel.resultPhrase.asset)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Text(viewModel.summaryText)
                    .font(.custom("Hanken Grotesk", size: 30))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack(spacing: 20) {
                    actionButton(title: "Go Home", color: Color("buttonMainColor"), textColor: Color(red: 0.89, green: 0.58, blue: 0.25)) {
                        viewModel.showHome = true
                    }
                    
                    actionButton(title: "All Results", color: Color(red: 0.89, green: 0.58, blue: 0.25), textColor: Color("buttonMainColor")) {
                        viewModel.showResults = true
                    }
                }
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $viewModel.showHome) {
            MainTabView(startWith: .home)
        }
        .fullScreenCover(isPresented: $viewModel.showResults) {
            MainTabView(startWith: .results)
        }
    }
    
    private func actionButton(title: String,
        color: Color,
        textColor: Color,
        action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Hanken Grotesk", size: 18))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        .frame(width: 140, height: 60)
        .background(color)
        .foregroundStyle(textColor)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        }
}
