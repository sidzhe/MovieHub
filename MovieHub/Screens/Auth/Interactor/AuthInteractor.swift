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
    
}
