//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol SearchViewProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol SearchInteractorInputProtocol: AnyObject {
    var presenter: SearchInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol SearchInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol SearchRouterProtocol: AnyObject {
    
}
