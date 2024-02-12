//
//  StubStorageService.swift
//  MovieHub
//
//  Created by sidzhe on 12.02.2024.
//

import Foundation

enum TestError: Error {
    case storageError
}

final class StubStorageService: StorageServiceProtocol {
    
    var currentUserResult: Result<UserEntity, Error>?
    
    func saveCurrentCity(name: String) {
        
    }
    
    func loadCurrentCity() -> String {
        return ""
    }
    
    func saveRecentModel(id: Int) {
        
    }
    
    func loadRecentModel() -> [String] {
        return [""]
    }
    
    func checkWish(id: Int) {
        
    }
    
    func getWishModel() -> [String] {
        return [""]
    }
    
    func wishStateButton(id: Int) -> Bool {
        false
    }
    
    func saveUser(user: AuthModel) -> Result<Void, Error> {
        return .success(())
    }
    
    func checkUserInfo(email: String) -> Bool {
        false
    }
    
    func loginUser(email: String, password: String) -> Result<Void, Error> {
        return .success(())
    }
    
    func updateUserInfo(_ user: UserEntity, newUserInfo: AuthModel) {
        
    }
    
    func getCurrentUser() -> Result<UserEntity, Error> {
        return currentUserResult ?? .failure(TestError.storageError)
    }
    
    func checkCurrentUser() -> Bool {
        false
    }
    
    func logoutCurrentUser() {
        
    }
}
