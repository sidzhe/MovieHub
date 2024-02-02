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
    
    func saveUser(user: AuthModel) -> Result<Void, Error>
    func checkUserInfo(email: String) -> Bool
    func loginUser(email: String, password: String) -> Result<UserModel, Error>
    func updateUserInfo(_ user: UserModel, newUserInfo: AuthModel)
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
    func saveUser(user: AuthModel) -> Result<Void, Error> {
        if checkUserInfo(email: user.email) {
            return .failure(NSError(domain: "UserAlreadyExists", code: 1, userInfo: [NSLocalizedDescriptionKey: "Пользователь с таким email уже существует"]))
        }

        let newUser = UserModel(context: viewContext)
        newUser.userName = user.name
        newUser.userEmail = user.email
        newUser.password = user.password
        newUser.userAvatar = user.avatar

        do {
            try viewContext.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func checkUserInfo(email: String) -> Bool {
        let fetchRequest: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@", email)

        do {
            let result = try viewContext.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Ошибка при загрузке информации о пользователе: \(error.localizedDescription)")
            return false
        }
    }
    
    func loginUser(email: String, password: String) -> Result<UserModel, Error> {
        let fetchRequest: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@ AND password == %@", email, password)

        do {
            let result = try viewContext.fetch(fetchRequest)
            if let user = result.first {
                return .success(user)
            } else {
                return .failure(NSError(domain: "LoginError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Неверный email или пароль"]))
            }
        } catch {
            return .failure(error)
        }
    }
    
    func updateUserInfo(_ user: UserModel, newUserInfo: AuthModel) {
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
