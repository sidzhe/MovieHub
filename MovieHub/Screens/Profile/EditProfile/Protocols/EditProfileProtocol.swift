//
//  EditProfileProtocol.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 14.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol EditProfileViewProtocol: AnyObject {
    var presenter: EditProfilePresenterProtocol? { get set }

    func updateProfileInfo(user: UserEntity)
    func displayError(error: String)
}

/// VIEW -> PRESENTER
protocol EditProfilePresenterProtocol: AnyObject {
    var view: EditProfileViewProtocol? { get set }

    func updateUserInfo(_ user: AuthModel)
    func getUserInfo()

}

/// PRESENTER -> INTERACTOR
protocol EditProfileInteractorInputProtocol: AnyObject {
    var presenter: EditProfileInteractorOutputProtocol? { get set }
    var user: UserEntity? { get set }
 
    func updateUserInfo(newUserInfo: AuthModel)
    func getUserInfo() -> Result<UserEntity, Error>
}

/// INTERACTOR -> PRESENTER
protocol EditProfileInteractorOutputProtocol: AnyObject {
    
}

///// PRESENTER -> ROUTER
protocol EditProfileRouterProtocol: AnyObject {
    
}
