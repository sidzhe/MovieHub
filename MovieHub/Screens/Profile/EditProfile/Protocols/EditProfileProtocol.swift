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
    func saveButtonTap()
    func updateProfileInfo(user: UserModel)
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
    var user: UserModel? { get set }
 
    func updateUserInfo(newUserInfo: AuthModel)
    func getUserInfo() -> Result<UserModel, Error>
}

/// INTERACTOR -> PRESENTER
protocol EditProfileInteractorOutputProtocol: AnyObject {
    
}

///// PRESENTER -> ROUTER
//protocol ProfileRouterProtocol: AnyObject {
//    func pushToPolicies(from view: ProfileViewProtocol)
//    func pushToAboutUs(from view: ProfileViewProtocol)
//    
//}
