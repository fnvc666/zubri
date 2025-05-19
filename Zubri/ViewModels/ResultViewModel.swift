//
//  ResultViewModel.swift
//  Zubri
//
//  Created by Павел Сивак on 16/05/2025.
//
import Foundation
import CoreData

final class ResultViewModel: ObservableObject {
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func deleteResult(_ result: GameResult) {
        context.delete(result)
        
        do {
            try context.save()
            print("The result has been deleted")
        } catch {
            print("Failed to delete the result: \(error)")
        }
    }
}
