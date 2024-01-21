//
//  ProfileInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class ProfileInteractor: ProfileInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: ProfileInteractorOutputProtocol?
    private let networkService: NetworkService
    private let storageService: StorageServiceProtool
    
    //MARK: Init
    init(networkService: NetworkService, storageService: StorageServiceProtool, detailID: String) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func saveUser(name: String, email: String, avatar: Data) {
        storageService.saveUser(name: name, email: email, avatar: avatar)
    }
}
