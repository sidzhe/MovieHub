//
//  AuthProtocols.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol AuthViewProtocol: AnyObject {
    var presenter: AuthPresenterProtocol? { get set }
    func displayError(error: String)
}

/// VIEW -> PRESENTER
protocol AuthPresenterProtocol: AnyObject {
    var view: AuthViewProtocol? { get set }
    func addNewUser(user: AuthModel)
    func loginUser(email: String, password: String)
    func routeToTabBar()
}

/// PRESENTER -> INTERACTOR
protocol AuthInteractorInputProtocol: AnyObject {
    var presenter: AuthInteractorOutputProtocol? { get set }
    
    func addNewUser(user: AuthModel)
    func loginUser(email: String, password: String) -> Result<UserModel, Error> 

}

/// INTERACTOR -> PRESENTER
protocol AuthInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getError(error: RequestError)
}

/// PRESENTER -> ROUTER
protocol AuthRouterProtocol: AnyObject {
    func pushToTabBar(from view: AuthViewProtocol?)
}

