//
//  SubtopicsView.swift
//  Zubri
//
//  Created by Павел Сивак on 10/05/2025.
//

import SwiftUI

struct SubtopicsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var topic: Topic
    
    private var sortedSubtopics: [Subtopic] {
        let set = topic.subtopics as? Set<Subtopic> ?? Set<Subtopic>()
        return set.sorted { $0.order < $1.order }
    }
    
    var body: some View {
        
        let subtopics = sortedSubtopics
        
        return ZStack {
            Color(red: 0.95, green: 1, blue: 0.93)
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Text(topic.titleSafe)
                    .font(.custom("Hanken Grotesk", size: 32).bold())
                    .padding(.top)

                ScrollView {
                    VStack(spacing: 30) {
                        ForEach(subtopics) { subtopic in
                            NavigationLink {
                                CardsGameView(subtopic: subtopic)
                            } label: {
                                HStack(spacing: 30) {
                                    Image(subtopic.imageNameSafe)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))

                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(subtopic.titleSafe)
                                            .font(.custom("Hanken Grotesk", size: 20))
                                        Text("\(subtopic.wordsSafe.count) words")
                                            .bold()
                                    }
                                }
                                .frame(width: 300, height: 140, alignment: .leading)
                                .frame(maxWidth: .infinity)
                                .background(Color("backgroundMainColor"))
                                .clipShape(RoundedRectangle(cornerRadius: 22))
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action : {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Subtopics")
                            .offset(x: -5)
                    }
                }
            }
        }
    }
}

extension Subtopic {
    var titleSafe: String { title ?? "Untitled" }
    var imageNameSafe: String { imageName ?? "noImage" }
    var levelSafe: String { level ?? "B2" }
    var wordsSafe: [Word] {
        let set = words as? Set<Word> ?? []
        return set.sorted { $0.text ?? "" < $1.text ?? "" }
    }
    
}
