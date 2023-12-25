//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol PopularViewProtocol: AnyObject {
    var presenter: PopularPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol PopularPresenterProtocol: AnyObject {
    var view: PopularViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol PopularInteractorInputProtocol: AnyObject {
    var presenter: PopularInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol PopularInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol PopularRouterProtocol: AnyObject {
    
}
