//
//  CardsGameViewModel.swift
//  Zubri
//
//  Created by Павел Сивак on 19/05/2025.
//

import Foundation
import SwiftUI

@MainActor
final class CardsGameViewModel: ObservableObject {
    
    @Published var cards: [Card] = []
    @Published var currentIndex: Int = 0
    @Published var correctAnswersCount: Int = 0
    @Published var selectedAnswer: String? = nil
    @Published var wasCorrect: Bool? = nil

    let subtopic: Subtopic

    init(subtopic: Subtopic) {
        self.subtopic = subtopic
    }

    var currentCard: Card? {
        guard currentIndex < cards.count else { return nil }
        return cards[currentIndex]
    }

    var isFinished: Bool {
        currentIndex >= cards.count
    }

    func buildCards() async {
        guard cards.isEmpty else { return }

        let words = subtopic.wordsSafe
        let allWords = words.compactMap { $0.text }

        var temp: [Card] = []

        for wordOptional in words {
            guard let word = wordOptional.text else { continue }

            if let sentence = await SearchSentence().getSentence(for: word) {
                let escaped = NSRegularExpression.escapedTemplate(for: word)
                let pattern = "\\b\(escaped)\\b"
                let blanked = sentence.replacingOccurrences(
                    of: pattern,
                    with: String(repeating: "_", count: word.count),
                    options: [.regularExpression, .caseInsensitive]
                )

                let randomThree = allWords.filter { $0 != word }
                    .shuffled()
                    .prefix(3)

                let options = ([word] + randomThree).shuffled()

                temp.append(Card(sentence: blanked,
                                 correctWord: word,
                                 options: options))
            }
        }

        cards = temp.shuffled()
    }

    func checkAnswer(_ userAnswer: String, completion: @escaping () -> Void) {
        guard currentIndex < cards.count, selectedAnswer == nil else { return }

        selectedAnswer = userAnswer
        let correct = cards[currentIndex].correctWord == userAnswer
        wasCorrect = correct

        if correct {
            correctAnswersCount += 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.selectedAnswer = nil
            self.wasCorrect = nil
            self.currentIndex += 1
            completion()
        }
    }

    func skip() {
        if currentIndex < cards.count {
            currentIndex += 1
        }
    }
}
