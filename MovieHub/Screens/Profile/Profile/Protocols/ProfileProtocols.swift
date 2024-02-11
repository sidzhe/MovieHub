//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol ProfileViewProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func updateProfileInfo(user: UserEntity)
    func hideAuthButton(isToggle: Bool)
    func hideProfileView(isToggle: Bool)
    func displayError(error: String)
}

/// VIEW -> PRESENTER
protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    func getUserInfo()
    func hideToggleAuth()
    
    func routeToAuth()
    func routeToEditProfile()
    func routeToLanguage()
    func routeToNotification()
    func routeToPolicies()
    func routeToAboutUs()
}

/// PRESENTER -> INTERACTOR
protocol ProfileInteractorInputProtocol: AnyObject {
    var presenter: ProfileInteractorOutputProtocol? { get set }
    func getUserInfo() -> Result<UserEntity, Error>
    func checkCurrentUser() -> Bool
}

/// INTERACTOR -> PRESENTER
protocol ProfileInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol ProfileRouterProtocol: AnyObject {
    func pushToEditProfile(from view: ProfileViewProtocol)
    func pushToLanguage(from view: ProfileViewProtocol)
    func pushToNotification(from view: ProfileViewProtocol)
    func pushToPolicies(from view: ProfileViewProtocol)
    func pushToAboutUs(from view: ProfileViewProtocol)
    func pushToAuth(from view: ProfileViewProtocol) 
}
