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
    
    func updateUserInfo(_ newUserInfo: EditProfileModel) {
        interactor?.updateUserInfo(newUserInfo: newUserInfo)
    }
    
    func saveUser(user: EditProfileModel) {
        interactor?.saveUser(user: user)
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
