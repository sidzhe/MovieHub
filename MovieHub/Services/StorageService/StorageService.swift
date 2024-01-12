//
//  StorageService.swift
//  MovieHub
//
//  Created by sidzhe on 07.01.2024.
//

import Foundation
import CoreData

protocol StorageServiceProtool: AnyObject {
    func saveCurrentCity(name: String)
    func loadCurrnetCity() -> String
}

final class StorageService: StorageServiceProtool {

    //MARK: Properies
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constant.persistentContainerName)
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    //MARK: Save
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveCurrentCity(name: String) {
        let currentCity = CurrentCity(context: viewContext)
        currentCity.name = name
        saveContext()
    }
    
    func loadCurrnetCity() -> String {
        let currnetCity = CurrentCity.fetchRequest()
        
        do {
            let result = try viewContext.fetch(currnetCity)
            let output = result.last?.name
            return output ?? ""
        } catch let error {
            print("CurrnetCity load error \(error.localizedDescription)")
            return ""
        }
    }
}
