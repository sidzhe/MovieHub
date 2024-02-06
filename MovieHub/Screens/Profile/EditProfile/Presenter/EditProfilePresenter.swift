//
//  EditProfilePresenter.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 14.01.2024.
//

import Foundation

final class EditProfilePresenter: EditProfilePresenterProtocol {
    
    
    //MARK: Properties
    weak var view: EditProfileViewProtocol?
    var interactor: EditProfileInteractorInputProtocol?
    var router: EditProfileRouterProtocol?
    
    func updateUserInfo(_ newUserInfo: AuthModel) {
        interactor?.updateUserInfo(newUserInfo: newUserInfo)
    }
    
    func getSavedUser() -> UserModel {
        guard let savedUser = interactor?.user else { return UserModel() }
        return savedUser
    }
    
    func getUserInfo() {
        guard let userInfo = interactor?.getUserInfo() else { return }
        
        switch userInfo {
        case .success(let userInfo):
            view?.updateProfileInfo(user: userInfo)
        case .failure(let error):
            view?.displayError(error: error.localizedDescription)
        }
    }
    
    func logoutUser() {
        interactor?.logoutUser()
    }
    
    func routeToAuth() {
        guard let view = view else { return }
        router?.pushToAuth(from: view)
    }
}

//MARK: - Extension EditProfileInteractorOutputProtocol
extension EditProfilePresenter: EditProfileInteractorOutputProtocol {
    
}
