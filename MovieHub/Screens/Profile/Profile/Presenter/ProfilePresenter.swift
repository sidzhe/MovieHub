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
        guard let userInfo = interactor?.getUserInfo() else { return }
        switch userInfo {
        case .success(let userInfo):
            view?.updateProfileInfo(user: userInfo)
        case .failure(let error):
            view?.displayError(error: error.localizedDescription)
        }
    }
    
    func hideToggleAuth() {
        guard let currentUser = interactor?.checkCurrentUser() else { return }
        switch currentUser {
        case true:
            view?.hideAuthButton(isToggle: true)
            view?.hideProfileView(isToggle: false)
        case false:
            view?.hideAuthButton(isToggle: false)
            view?.hideProfileView(isToggle: true)
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
    
    func routeToAuth() {
        guard let view = view else { return }
        router?.pushToAuth(from: view)
    }
}


//MARK: - Extension ProfileInteractorOutputProtocol
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
}
