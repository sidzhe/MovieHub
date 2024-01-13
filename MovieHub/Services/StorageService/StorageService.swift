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
    func saveRecentModel(id: Int)
    func loadRecentModel() -> [String]
    func checkWish(id: Int)
    func getWishModel() -> [String]
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
    
    //MARK: Current city methods
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
    
    //MARK: Recent model methods
    private func deleteRecent(id: RecentModel) {
        viewContext.delete(id)
        saveContext()
    }
    
    func saveRecentModel(id: Int) {
        let fetchRequest = RecentModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", id.description)
        
        do {
            let existingId = try viewContext.fetch(fetchRequest)
            if let existingId = existingId.first {
                deleteRecent(id: existingId)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        let recentElement = RecentModel(context: viewContext)
        recentElement.recentId = id.description
        saveContext()
    }
    
    func loadRecentModel() -> [String] {
        let recentModel = RecentModel.fetchRequest()
        
        do {
            let result = try viewContext.fetch(recentModel)
            let output = result.map { $0.recentId ?? "" }
            return output
        } catch let error {
            print("CurrnetCity load error \(error.localizedDescription)")
            return [String]()
        }
    }
    
    //MARK: Wish methods
    private func deleteWish(id: WishModel) {
        viewContext.delete(id)
        saveContext()
    }
    
    private func addWish(id: Int) {
        let wishElement = WishModel(context: viewContext)
        wishElement.wishId = id.description
        saveContext()
    }
    
    func checkWish(id: Int) {
        let fetchRequest = WishModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wishId == %@", id.description)
        
        do {
            let existingId = try viewContext.fetch(fetchRequest)
            if let existingId = existingId.first {
                deleteWish(id: existingId)
                print("TYT")
            } else {
                addWish(id: id)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getWishModel() -> [String] {
        let currnetModel = WishModel.fetchRequest()
        
        do {
            let result = try viewContext.fetch(currnetModel)
            let output = result.map { $0.wishId ?? "" }
            return output
        } catch let error {
            print("Wish load error \(error.localizedDescription)")
            return [String]()
        }
    }
}
