//
//  EditProfileInteractor.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 14.01.2024.
//

import Foundation

final class EditProfileInteractor: EditProfileInteractorInputProtocol {

    //MARK: - Properties
    weak var presenter: EditProfileInteractorOutputProtocol?
    
    private let networkService: NetworkService
    private let storageService: StorageServiceProtool
    
    //MARK: Init
    init(networkService: NetworkService, storageService: StorageServiceProtool) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func saveUser(user: EditProfileModel) {
        storageService.saveUser(user: user)
    }
    
    func getUserInfo() -> UserModel? {
        let userInfo = storageService.getUserInfo()
        return userInfo
    }
}
