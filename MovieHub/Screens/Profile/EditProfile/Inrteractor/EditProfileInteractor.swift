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
    private let storageService: StorageServiceProtocol
    
    var user: UserEntity?

    //MARK: Init
    init(networkService: NetworkService, storageService: StorageServiceProtocol) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func updateUserInfo(newUserInfo: AuthModel) {
        guard let user else { return }
        storageService.updateUserInfo(user, newUserInfo: newUserInfo)
    }
    
    func getUserInfo() -> Result<UserEntity, Error> {
        storageService.getCurrentUser()
    }
    
    func logoutUser(completion: (() -> Void)?) {
        storageService.logoutCurrentUser()
    }
}
