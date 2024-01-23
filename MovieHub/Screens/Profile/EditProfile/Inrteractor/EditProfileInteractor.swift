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
    
    func saveUser(userName: String, userEmail: String, userAvatar: Data?) {
        storageService.saveUser(
            userName: userName,
            userEmail: userEmail,
            userAvatar: userAvatar
        )
    }
    
    func getUserInfo() -> UserModel? {
        let userInfo = storageService.getUserInfo()
        return userInfo
    }
}
