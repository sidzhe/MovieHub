//
//  StorageService.swift
//  MovieHub
//
//  Created by sidzhe on 07.01.2024.
//

import Foundation
import CoreData

protocol StorageServiceProtocol: AnyObject {
    func saveCurrentCity(name: String)
    func loadCurrnetCity() -> String
    func saveRecentModel(id: Int)
    func loadRecentModel() -> [String]
    func checkWish(id: Int)
    func getWishModel() -> [String]
    func wishStateButton(id: Int) -> Bool
    func saveUser(user: EditProfileModel)
    func updateUserInfo(_ user: UserModel, newUserInfo: EditProfileModel)
    func getUserInfo() -> UserModel?
}

final class StorageService: StorageServiceProtocol {

    //MARK: Properies
    private let persistentContainer: NSPersistentContainer = {
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
        fetchRequest.predicate = NSPredicate(format: "recentId == %@", id.description)
        
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
            return output.reversed()
        } catch let error {
            print("CurrnetCity load error \(error.localizedDescription)")
            return [String]()
        }
    }
    
    //MARK: Profile Methods
    func saveUser(user: EditProfileModel) {
        let newUser = UserModel(context: viewContext)
        newUser.userName = user.name
        newUser.userEmail = user.email
        newUser.userAvatar = user.avatar
        saveContext()
    }
    
    func updateUserInfo(_ user: UserModel, newUserInfo: EditProfileModel) {
        user.userName = newUserInfo.name
        user.userEmail = newUserInfo.email
        user.userAvatar = newUserInfo.avatar
        saveContext()
    }
    

    func getUserInfo() -> UserModel? {
        let currentUserRequest = UserModel.fetchRequest()

        do {
            let result = try viewContext.fetch(currentUserRequest)
            return result.last
        } catch {
            print("Current user load error \(error.localizedDescription)")
            return nil
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
        wishElement.isSelected = true
        saveContext()
    }
    
    func checkWish(id: Int) {
        let fetchRequest = WishModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wishId == %@", id.description)
        
        do {
            let existingId = try viewContext.fetch(fetchRequest)
            if let existingId = existingId.first {
                deleteWish(id: existingId)
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
            let output = result.map { $0.wishId ?? Constant.none }
            return output
        } catch let error {
            print("Wish load error \(error.localizedDescription)")
            return [String]()
        }
    }
    
    func wishStateButton(id: Int) -> Bool {
        let fetchRequest = WishModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wishId == %@", id.description)
        
        do {
            let existingId = try viewContext.fetch(fetchRequest)
            if let existingId = existingId.first {
                return existingId.isSelected
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return false
    }
}
