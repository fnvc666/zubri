//
//  CardsGameView.swift
//  Zubri
//
//  Created by Павел Сивак on 11/05/2025.
//

import SwiftUI

struct CardsGameView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: CardsGameViewModel

    init(subtopic: Subtopic) {
        _viewModel = StateObject(wrappedValue: CardsGameViewModel(subtopic: subtopic))
    }

    var body: some View {
        ZStack {
            Color("backgroundMainColor")
                .ignoresSafeArea()
            
            if viewModel.cards.isEmpty {
                ProgressView()
                    .task {
                        await viewModel.buildCards()
                    }
            } else {
                ZStack {
                    if !viewModel.isFinished, let card = viewModel.currentCard {
                        CardView(
                            viewModel: CardViewModel(
                                card: card,
                                totalCount: viewModel.cards.count,
                                currentIndex: viewModel.currentIndex,
                                onSkip: {
                                    withAnimation {
                                        viewModel.skip()
                                    }
                                },
                                onAnswerTap: { answer in
                                    viewModel.checkAnswer(answer) { }
                                }
                            ),
                            selectedAnswer: viewModel.selectedAnswer,
                            wasCorrect: viewModel.wasCorrect
                        )
                        .id(viewModel.currentIndex)
                        .transition(.move(edge: .leading))
                    } else {
                        ResultAfterGameView(
                            subtopic: viewModel.subtopic,
                            correct: viewModel.correctAnswersCount,
                            total: viewModel.cards.count
                        )
                    }
                }
                .animation(.easeInOut, value: viewModel.currentIndex)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                    Text(viewModel.subtopic.titleSafe)
                        .offset(x: -5)
                }
            }
        }
    }
}
