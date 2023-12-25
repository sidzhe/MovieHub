//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol MainInteractorInputProtocol: AnyObject {
    var presenter: MainInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol MainInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol MainRouterProtocol: AnyObject {
    
}
