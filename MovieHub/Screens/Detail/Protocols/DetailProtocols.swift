//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol DetailViewProtocol: AnyObject {
    var presenter: DetailPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol DetailInteractorInputProtocol: AnyObject {
    var presenter: DetailInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol DetailInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol DetailRouterProtocol: AnyObject {
    
}
