//
//  HomeViewModel.swift
//  Zubri
//
//  Created by Павел Сивак on 16/05/2025.
//

import Foundation
import CoreData
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var topics: [Topic] = []
    @Published var currentStreak: Int

    private let context: NSManagedObjectContext
    private let streakManager: StreakManager
    private var cancellables = Set<AnyCancellable>()

    init(context: NSManagedObjectContext,
         streakManager: StreakManager = StreakManager())
    {
        self.context = context
        self.streakManager = streakManager
        self.currentStreak = streakManager.currentStreak

        fetchTopics()

        NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave,
                                             object: context)
            .sink { [weak self] _ in self?.fetchTopics() }
            .store(in: &cancellables)

        streakManager.$currentStreak
            .receive(on: RunLoop.main)
            .assign(to: &$currentStreak)
    }

    private func fetchTopics() {
        let request = Topic.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Topic.title,
                                                    ascending: true)]

        context.perform {
            self.topics = (try? self.context.fetch(request)) ?? []
        }
    }
}
