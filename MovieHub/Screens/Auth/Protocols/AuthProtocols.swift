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

}

/// VIEW -> PRESENTER
protocol AuthPresenterProtocol: AnyObject {
    var view: AuthViewProtocol? { get set }
   
}

/// PRESENTER -> INTERACTOR
protocol AuthInteractorInputProtocol: AnyObject {
    var presenter: AuthInteractorOutputProtocol? { get set }

}

/// INTERACTOR -> PRESENTER
protocol AuthInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getError(error: RequestError)
}

/// PRESENTER -> ROUTER
protocol AuthRouterProtocol: AnyObject {
    func pushToMain(from view: AuthViewProtocol?, id: Int)

}

