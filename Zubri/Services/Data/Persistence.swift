//
//  Persistence.swift
//  Zubri
//
//  Created by Павел Сивак on 09/05/2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    @MainActor
    static let preview: PersistenceController = {
        PersistenceController(inMemory: true)
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Zubri")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        preloadIfNeeded()
    }
    
    func saveMainContext() {
        let ctx = container.viewContext
        if ctx.hasChanges { try? ctx.save()}
    }
    
    // DELETE BEFORE REALESE
    private func deleteAll(in context: NSManagedObjectContext) {
        let entityNames = ["Topic", "Subtopic", "Word", "Result"]

        for entityName in entityNames {
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let request = NSBatchDeleteRequest(fetchRequest: fetch)
            _ = try? context.execute(request)
        }
    }

    
    private func preloadIfNeeded() {
        
        deleteAll(in: container.viewContext)
        
        guard
            let url = Bundle.main.url(forResource: "seedBig", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let seed = try? JSONDecoder().decode(Seed.self, from: data)
        else { print("seed.json not found"); return }
        
        container.performBackgroundTask { ctx in
            seed.topics.forEach { $0.insert(into: ctx) }
            try? ctx.save()
        }
    }
}
