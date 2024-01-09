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
    func displayRequestError(error: RequestError)
}

/// VIEW -> PRESENTER
protocol ChristmasPresenterProtocol: AnyObject {
    var view: ChristmasViewProtocol? { get set }
    var backgroundAnimationCount: Int { get set }
    var boomAnimationCount: Int { get set }
    func getLoadedMovie() -> DetailModel?
    func fetchRequest()
    func routeToDetailVC()
}

/// PRESENTER -> INTERACTOR
protocol ChristmasInteractorInputProtocol: AnyObject {
    var loadedMovie: DetailModel? { get }
    var presenter: ChristmasInteractorOutputProtocol? { get set }
    func getMovieWithId()
}

/// INTERACTOR -> PRESENTER
protocol ChristmasInteractorOutputProtocol: AnyObject {
    func getRequsetError(_ error: RequestError)
}

/// PRESENTER -> ROUTER
protocol ChristmasRouterProtocol: AnyObject {
    func pushToDetailMovie(from view: ChristmasViewProtocol?)
}
