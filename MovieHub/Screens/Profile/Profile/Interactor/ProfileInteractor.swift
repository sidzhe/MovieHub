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
    private let storageService: StorageServiceProtocol
    
    //MARK: Init
    init(networkService: NetworkService, storageService: StorageServiceProtocol) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func getUserInfo() -> Result<UserModel, Error> {
      storageService.getCurrentUser()
    }
}
