//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol MovieListViewProtocol: AnyObject {
    var presenter: MovieListPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol MovieListPresenterProtocol: AnyObject {
    var view: MovieListViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol MovieListInteractorInputProtocol: AnyObject {
    var presenter: MovieListInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol MovieListInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol MovieListRouterProtocol: AnyObject {
    
}
