//
//  ResultAfterGameViewModel.swift
//  Zubri
//
//  Created by Павел Сивак on 16/05/2025.
//
import Foundation
import CoreData

@MainActor
class ResultAfterGameViewModel: ObservableObject {
    
    @Published var showHome = false
    @Published var showResults = false
    
    let resultPhrase: (text: String, asset: String)
    let summaryText: String
    
    private let context: NSManagedObjectContext
    
    init(subtopic: Subtopic,
         correct: Int,
         total: Int,
         context: NSManagedObjectContext)
    {
        self.context = context
        
        let fraction = total == 0 ? 0 : Float(correct) / Float(total)
        
        switch fraction {
        case 0...0.40:  resultPhrase = ("Practise more!",  "practiseMoreResult")
        case 0.41...0.60: resultPhrase = ("Could be better","couldBeBetterResult")
        case 0.61...0.75: resultPhrase = ("Keep going!",     "normalResult")
        case 0.76...1.00: resultPhrase = ("Well done!",      "goodResult")
        default:          resultPhrase = ("Good!",           "goodResult")
        }
        
        summaryText = "\(correct) correct answers of \(total) questions!"

        save(subtopic: subtopic, fraction: fraction)
    }
    
    private func save(subtopic: Subtopic, fraction: Float) {
        let result = GameResult(context: context)
        result.imageName     = subtopic.imageNameSafe
        result.subtopic      = subtopic.titleSafe
        result.scoreFraction = fraction
        result.date          = Date()
        try? context.save()
    }
}
