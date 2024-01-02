//
//  PersonDetailProtocols.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol PersonDetailViewProtocol: AnyObject {
    var presenter: PersonDetailPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol PersonDetailPresenterProtocol: AnyObject {
    var view: PersonDetailViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol PersonDetailInteractorInputProtocol: AnyObject {
    var presenter: PersonDetailInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol PersonDetailInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol PersonDetailRouterProtocol: AnyObject {
    
}
