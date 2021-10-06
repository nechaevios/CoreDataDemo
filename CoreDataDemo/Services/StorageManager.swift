//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Nechaev Sergey  on 06.10.2021.
//

import Foundation
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createManagedObject<T>(forEntityName: String, inContext: NSManagedObjectContext, withType: T.Type) -> T? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: forEntityName, in: inContext) else { return nil}
        guard let managedObject = NSManagedObject(entity: entityDescription, insertInto: inContext) as? T else { return nil}
        
        return managedObject
    }
    
}
