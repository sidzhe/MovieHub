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
    func saveRecentModel(id: Int, currentUserID: UUID)
    func loadRecentModel(currentUserID: UUID) -> [String]
    func checkWish(id: Int, currentUserID: UUID)
    func getWishModel() -> [String]
    func wishStateButton(id: Int) -> Bool
    
    func saveUser(user: AuthModel) -> Result<Void, Error>
    func checkUserInfo(email: String) -> Bool
    func loginUser(email: String, password: String) -> Result<Void, Error>
    func updateUserInfo(_ user: UserModel, newUserInfo: AuthModel)
    func getCurrentUser() -> Result<UserModel, Error>
    func checkCurrentUser() -> Bool
    func logoutCurrentUser()
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
    
    func saveRecentModel(id: Int, currentUserID: UUID) {
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
        recentElement.user?.userID = currentUserID
        saveContext()
    }
    
    func loadRecentModel(currentUserID: UUID) -> [String] {
        let recentModel = RecentModel.fetchRequest()
        recentModel.predicate = NSPredicate(format: "user.userID == %@", currentUserID.description)
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
    //сохранение нового пользователя в БД
    func saveUser(user: AuthModel) -> Result<Void, Error> {
        if checkUserInfo(email: user.email) {
            return .failure(NSError(domain: "UserAlreadyExists", code: 1, userInfo: [NSLocalizedDescriptionKey: "Пользователь с таким email уже существует"]))
        }
        
        let newUser = UserModel(context: viewContext)
        newUser.userID = UUID()
        newUser.userName = user.name
        newUser.userEmail = user.email
        newUser.password = user.password
        newUser.userAvatar = user.avatar
        newUser.isCurrent = false
        
        do {
            try viewContext.save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    //     проверка наличия пользователя с вводимым мэйлом
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
    
    //     проверка наличия авторизованного пользователя
    func checkCurrentUser() -> Bool {
        let fetchRequest: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCurrent == true")
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            return !result.isEmpty
        } catch {
            print("Ошибка при проверке текущего пользователя: \(error.localizedDescription)")
            return false
        }
    }
    
    //    авторизация пользователя
    func loginUser(email: String, password: String) -> Result<Void, Error> {
        let fetchRequest: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userEmail == %@ AND password == %@", email, password)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if result.isEmpty {
                return .failure(NSError(domain: "LoginError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Неверный email или пароль"]))
            } else {
                if let user = result.first {
                    user.isCurrent = true
                    for otherUser in result where otherUser != user {
                        otherUser.isCurrent = false
                    }
                    try viewContext.save()
                }
                return .success(())
            }
        } catch {
            return .failure(error)
        }
    }
    //    обновление информации пользователя
    func updateUserInfo(_ user: UserModel, newUserInfo: AuthModel) {
        if let newName = newUserInfo.name {
            user.userName = newName
        }
        
        user.userEmail = newUserInfo.email
        
        if let newAvatar = newUserInfo.avatar {
            user.userAvatar = newAvatar
        }
        
        user.password = newUserInfo.password
        saveContext()
    }
    
    //    получение текущего пользователя
    func getCurrentUser() -> Result<UserModel, Error> {
        let fetchRequest: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCurrent == true")
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let user = result.last {
                return .success(user)
            } else {
                return .failure(NSError(domain: "CurrentUserError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Гостевой визит не позволяет использовать все возможности приложения"]))
            }
        } catch {
            return .failure(error)
        }
    }
    //    выход из аккаунта
    func logoutCurrentUser() {
        let fetchRequest: NSFetchRequest<UserModel> = UserModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCurrent == true")
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let currentUser = result.first {
                currentUser.isCurrent = false
                try viewContext.save()
            }
        } catch {
            print("Ошибка при выходе из аккаунта: \(error.localizedDescription)")
        }
    }
    
    //MARK: Wish methods
    private func deleteWish(id: WishModel) {
        viewContext.delete(id)
        saveContext()
    }
    
    private func addWish(id: Int, currentUserID: UUID) {
        let wishElement = WishModel(context: viewContext)
        wishElement.wishId = id.description
        wishElement.user?.userID = currentUserID
        wishElement.isSelected = true
        saveContext()
    }
    
    func checkWish(id: Int, currentUserID: UUID) {
        let fetchRequest = WishModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "wishId == %@", id.description)
        
        do {
            let existingId = try viewContext.fetch(fetchRequest)
            if let existingId = existingId.first {
                deleteWish(id: existingId)
            } else {
                addWish(id: id, currentUserID: currentUserID)
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
