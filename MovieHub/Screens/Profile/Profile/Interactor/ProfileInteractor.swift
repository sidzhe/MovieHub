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
    init(networkService: NetworkService, storageService: StorageServiceProtool) {
        self.networkService = networkService
        self.storageService = storageService
    }
    func getUserInfo() -> UserModel? {
       let user =  storageService.getUserInfo()
        return user
    }
}
