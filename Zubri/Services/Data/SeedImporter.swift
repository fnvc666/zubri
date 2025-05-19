//
//  SeedImporter.swift
//  Zubri
//
//  Created by Павел Сивак on 09/05/2025.
//

import CoreData

struct Seed: Decodable { let topics: [TopicDTO] }

struct TopicDTO: Decodable {
    let id: UUID, title: String, emoji: String, order: Int16, subtopics: [SubDTO]
    func insert(into ctx: NSManagedObjectContext) {
        let t = Topic(context: ctx)
        t.id = id; t.title = title; t.emoji = emoji; t.order = order
        subtopics.forEach { $0.insert(parent: t, ctx: ctx) }
    }
}

struct SubDTO: Decodable {
    let id: UUID, title: String, level: String, imageName: String, order: Int16, words: [WordDTO]
    func insert(parent: Topic, ctx: NSManagedObjectContext) {
        let s = Subtopic(context: ctx)
        s.id = id; s.title = title; s.level = level; s.imageName = imageName; s.order = order; s.topic = parent
        words.forEach { $0.insert(parent: s, ctx: ctx) }
    }
}

struct WordDTO: Decodable {
    let id: UUID, text: String
    func insert(parent: Subtopic, ctx: NSManagedObjectContext) {
        let w = Word(context: ctx)
        w.id = id; w.text = text; w.subtopic = parent
    }
}
