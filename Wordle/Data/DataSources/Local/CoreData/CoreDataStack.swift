//
//  CoreDataStack.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation
import CoreData


final class CoreDataStack {
    
    //MARK: - Singleton
    static let shared = CoreDataStack()
    private init() {}
    
    //MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WordleModel")
        
        container.loadPersistentStores{ storeDescription, error in
            if let error = error as? NSError {
                fatalError("error in load CoreData \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    //MARK: - Context
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    //MARK: - Save
    func saveContext() {
        let context = viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    //MARK: - Branch
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}
