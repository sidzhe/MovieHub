//
//  ProfilePresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {

    //MARK: Properties
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var router: ProfileRouterProtocol?
    
    func getUserInfo() {
        if let userInfo = interactor?.getUserInfo() {
            view?.updateProfileInfo(user: userInfo)
        } else {
            print("ошибка получения данных для профиля")
        }
    }
    
    
    //MARK: Route
    func routeToEditProfile() {
        guard let view = view else { return }
        router?.pushToEditProfile(from: view)
    }
    
    func routeToLanguage() {
        guard let view = view else { return }
        router?.pushToLanguage(from: view)
    }
    
    func routeToNotification() {
        guard let view = view else { return }
        router?.pushToNotification(from: view)
    }
    
    func routeToPolicies() {
        guard let view = view else { return }
        router?.pushToPolicies(from: view)
    }
    
    func routeToAboutUs() {
        guard let view = view else { return }
        router?.pushToAboutUs(from: view)
    }
}


//MARK: - Extension ProfileInteractorOutputProtocol
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
}
