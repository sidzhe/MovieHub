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
    
    func updateUserInfo(_ newUserInfo: AuthModel) {
        interactor?.updateUserInfo(newUserInfo: newUserInfo)
    }
    
    func getSavedUser() -> UserModel {
        guard let savedUser = interactor?.user else { return UserModel() }
      return savedUser
    }
    
    func getUserInfo() {
        if let userInfo = interactor?.getUserInfo() {
            view?.updateProfileInfo(user: userInfo)
        } else {
            print("ошибка получения данных для профиля")
        }
    }
}

//MARK: - Extension EditProfileInteractorOutputProtocol
extension EditProfilePresenter: EditProfileInteractorOutputProtocol {
    
}
