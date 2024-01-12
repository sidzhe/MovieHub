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
}

/// VIEW -> PRESENTER
protocol ProfilePresenterProtocol: AnyObject {
    var view: ProfileViewProtocol? { get set }
    func routeToPolicies()
    func routeToAboutUs()
}

/// PRESENTER -> INTERACTOR
protocol ProfileInteractorInputProtocol: AnyObject {
    var presenter: ProfileInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol ProfileInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol ProfileRouterProtocol: AnyObject {
    func pushToPolicies(from view: ProfileViewProtocol)
    func pushToAboutUs(from view: ProfileViewProtocol)
    
}
