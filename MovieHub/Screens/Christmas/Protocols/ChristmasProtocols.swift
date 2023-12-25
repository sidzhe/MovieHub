//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol ChristmasViewProtocol: AnyObject {
    var presenter: ChristmasPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol ChristmasPresenterProtocol: AnyObject {
    var view: ChristmasViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol ChristmasInteractorInputProtocol: AnyObject {
    var presenter: ChristmasInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol ChristmasInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol ChristmasRouterProtocol: AnyObject {
    
}
