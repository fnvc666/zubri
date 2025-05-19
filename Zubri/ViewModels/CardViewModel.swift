//
//  CardViewModel.swift
//  Zubri
//
//  Created by Павел Сивак on 19/05/2025.
//

import SwiftUI

final class CardViewModel {
    let card: Card
    let totalCount: Int
    let currentIndex: Int
    let onSkip: () -> Void
    let onAnswerTap: (String) -> Void

    init(card: Card,
         totalCount: Int,
         currentIndex: Int,
         onSkip: @escaping () -> Void,
         onAnswerTap: @escaping (String) -> Void) {
        self.card = card
        self.totalCount = totalCount
        self.currentIndex = currentIndex
        self.onSkip = onSkip
        self.onAnswerTap = onAnswerTap
    }
}
