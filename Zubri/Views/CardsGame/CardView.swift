//
//  CardView.swift
//  Zubri
//
//  Created by Павел Сивак on 11/05/2025.
//

import SwiftUI

struct CardView: View {
    
    let viewModel: CardViewModel
    let selectedAnswer: String?
    let wasCorrect: Bool?
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<viewModel.totalCount, id: \.self) { indx in
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(indx <= viewModel.currentIndex ? .black : .gray)
                }
            }
            .padding(.top)

            Spacer()

            ZStack {
                if !viewModel.card.options.isEmpty {
                    Text(viewModel.card.sentence)
                        .multilineTextAlignment(.center)
                        .frame(width: 250, height: 250)
                } else {
                    ProgressView()
                        .frame(width: 250, height: 250)
                }
            }
            .frame(width: 320, height: 210)
            .background(Color(red: 0.95, green: 1, blue: 0.93))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding()

            VStack(spacing: 20) {
                let options = viewModel.card.options
                ForEach(0..<2) { row in
                    HStack(spacing: 20) {
                        ForEach(0..<2) { col in
                            let index = row * 2 + col
                            if index < options.count {
                                let option = options[index]
                                Button {
                                    viewModel.onAnswerTap(option)
                                } label: {
                                    Text(option)
                                        .font(.custom("Hanken Grotesk", size: 20).weight(.regular))
                                        .tint(.black)
                                }
                                .frame(width: 120, height: 60)
                                .background(optionColor(option))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .allowsHitTesting(selectedAnswer == nil)
                            }
                        }
                    }
                }
            }

            Spacer()

            Button {
                viewModel.onSkip()
            } label: {
                Text("Skip")
                    .font(.custom("Hanken Grotesk", size: 32))
                    .tint(Color("buttonMainColor"))
            }
            .disabled(selectedAnswer != nil)

            Spacer()
        }
    }
    
    private func optionColor(_ option: String) -> Color {
        if let selected = selectedAnswer {
            if option == selected {
                return wasCorrect == true ? .green : .red
            } else {
                return Color(red: 0.89, green: 0.58, blue: 0.25)
            }
        } else {
            return Color(red: 0.89, green: 0.58, blue: 0.25)
        }
    }
}
