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
    
    func updateUserInfo(userName: String, userEmail: String, userAvatar: Data?) {
        interactor?.saveUser(
            userName: userName,
            userEmail: userEmail,
            userAvatar: userAvatar
        )
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
