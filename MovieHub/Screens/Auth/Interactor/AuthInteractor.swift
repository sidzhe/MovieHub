//
//  AuthInteractor.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.01.2024.
//

import Foundation

final class AuthInteractor: AuthInteractorInputProtocol {

    var presenter: AuthInteractorOutputProtocol?
    let storageService: StorageServiceProtocol
    
    //MARK: Init
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func addNewUser(user: AuthModel) -> Result<Void, Error> {
        storageService.saveUser(user: user)
    }
    
    func loginUser(email: String, password: String) -> Result<Void, Error> {
        storageService.loginUser(email: email, password: password)
    }
}
