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
    func loadCurrentCity() -> String
    
    func saveRecentModel(id: Int)
    func loadRecentModel() -> [String]
    
    func checkWish(id: Int)
    func getWishModel() -> [String]
    func wishStateButton(id: Int) -> Bool
    
    func saveUser(user: AuthModel) -> Result<Void, Error>
    func checkUserInfo(email: String) -> Bool
    func loginUser(email: String, password: String) -> Result<Void, Error>
    func updateUserInfo(_ user: UserEntity, newUserInfo: AuthModel)
    func getCurrentUser() -> Result<UserEntity, Error>
    func checkCurrentUser() -> Bool
    func logoutCurrentUser()
}

final class StorageService: StorageServiceProtocol {
    
    //MARK: Properties
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constant.persistentContainerName)
        container.loadPersistentStores { description, error in
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
    
    private func currentUserFetchRequest() -> NSFetchRequest<UserEntity> {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCurrent == true")
        return fetchRequest
    }
    
    //MARK: Profile Methods
    //сохранение нового пользователя в БД
    func saveUser(user: AuthModel) -> Result<Void, Error> {
        
        if checkUserInfo(email: user.email) {
            return .failure(NSError(domain: "UserAlreadyExists", code: 1,
                                    userInfo: [NSLocalizedDescriptionKey: "Пользователь с таким email уже существует"])
            )
        }
        
        let newUser = UserEntity(context: viewContext)
        newUser.userName = user.name
        newUser.userEmail = user.email
        newUser.password = user.password
        newUser.userAvatar = user.avatar
        newUser.isCurrent = false
        
        saveContext()
        return .success(())
    }
    
    //     проверка наличия пользователя с вводимым мэйлом
    func checkUserInfo(email: String) -> Bool {
        let fetchRequest = UserEntity.fetchRequest()
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
        let fetchRequest = currentUserFetchRequest()
        
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
        let fetchRequest = UserEntity.fetchRequest()
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
                    saveContext()
                }
                return .success(())
            }
        } catch {
            return .failure(error)
        }
    }
    //    обновление информации пользователя
    func updateUserInfo(_ user: UserEntity, newUserInfo: AuthModel) {
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
    func getCurrentUser() -> Result<UserEntity, Error> {
        let fetchRequest = currentUserFetchRequest()
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let user = result.last {
                return .success(user)
            } else {
                return .failure(NSError(domain: "CurrentUserError", 
                                        code: 1,
                                        userInfo: [NSLocalizedDescriptionKey: "Гостевой визит не позволяет использовать все возможности приложения"])
                )
            }
        } catch {
            return .failure(error)
        }
    }
    
    //    выход из аккаунта
    func logoutCurrentUser() {
        let fetchRequest = currentUserFetchRequest()
        
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
    
    
    //MARK: Current city methods
    func saveCurrentCity(name: String) {
        let fetchRequest = currentUserFetchRequest()
        
        do {
            if let currentUser = try viewContext.fetch(fetchRequest).first {
                
                let currentCity = CurrentCityEntity(context: viewContext)
                currentCity.name = name
                currentUser.addToCities(currentCity)
                
                saveContext()
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
        }
    }
    
    func loadCurrentCity() -> String {
        let fetchRequest = currentUserFetchRequest()
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let currentUser = result.first,
               let citySet = currentUser.cities as? Set<CurrentCityEntity>,
               let currentCity = citySet.first {
                return currentCity.name ?? ""
            }
            return ""
        } catch {
            print("CurrentCity load error: \(error.localizedDescription)")
            return ""
        }
    }
    
    //MARK: Recent model methods
    
    func saveRecentModel(id: Int) {
        
        let fetchRequest = currentUserFetchRequest()
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let currentUser = result.first,
               let recentForUserSet = currentUser.recentMovies?.mutableCopy() as? Set<RecentEntity> {
                
                
                if let existingRecentEntity = recentForUserSet.first(where: { $0.recentId == id.description }) {
                    currentUser.removeFromRecentMovies(existingRecentEntity)
                }
                
                let recentEntity = RecentEntity(context: viewContext)
                recentEntity.recentId = id.description
                currentUser.addToRecentMovies(recentEntity)
                
                saveContext()
            }
        } catch {
            print("Error saving recent model: \(error.localizedDescription)")
        }
    }
    
    func loadRecentModel() -> [String] {
        let fetchRequest = currentUserFetchRequest()
        do {
            let result = try viewContext.fetch(fetchRequest).first
            if let recentForUserSet = result?.recentMovies?.mutableCopy() as? Set<RecentEntity> {
                
                let output = recentForUserSet.map { $0.recentId ?? "" }
                return output
            }
            return []
        } catch let error {
            print("CurrnetCity load error \(error.localizedDescription)")
            return [String]()
        }
    }
    
    
    
    //MARK: Wish methods
    private func deleteWish(id: WishEntity) {
        viewContext.delete(id)
        saveContext()
    }
    
    private func addWish(id: Int) {
        let fetchRequest = currentUserFetchRequest()
        
        do {
            if let currentUser = try viewContext.fetch(fetchRequest).first {
                let wishElement = WishEntity(context: viewContext)
                wishElement.wishId = id.description
                wishElement.isSelected = true
                currentUser.addToWishes(wishElement)
                saveContext()
            }
        } catch let error {
            print("Wish save error \(error.localizedDescription)")
        }
    }
    
    func checkWish(id: Int) {
        let fetchRequest = currentUserFetchRequest()
        
        do {
            if let currentUser = try viewContext.fetch(fetchRequest).first {
                let existingWishRequest = WishEntity.fetchRequest()
                existingWishRequest.predicate = NSPredicate(format: "wishId == %@", id.description)
                
                if let existingWish = try currentUser.managedObjectContext?.fetch(existingWishRequest).first as? WishEntity {
                    deleteWish(id: existingWish)
                } else {
                    addWish(id: id)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getWishModel() -> [String] {
        let fetchRequest = currentUserFetchRequest()
        
        do {
             let result = try viewContext.fetch(fetchRequest).first
            if let existingWish = result?.wishes as? Set<WishEntity> {
                let output = existingWish.map { $0.wishId ?? Constant.none }
               
                return output
            }
            return []
        } catch let error {
            print("Wish load error \(error.localizedDescription)")
            return [String]()
        }
    }
    
    func wishStateButton(id: Int) -> Bool {
        let fetchRequest = WishEntity.fetchRequest()
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
