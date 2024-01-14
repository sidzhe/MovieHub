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
    func routeToDetail()
}

/// PRESENTER -> INTERACTOR
protocol ChristmasInteractorInputProtocol: AnyObject {
    var presenter: ChristmasInteractorOutputProtocol? { get set }
    var loadedMovie: DetailModel? { get }
    var previousModel: DetailModel? { get }
    func getMovieWithId()
}

/// INTERACTOR -> PRESENTER
protocol ChristmasInteractorOutputProtocol: AnyObject {
    func getRequsetError(_ error: RequestError)
}

/// PRESENTER -> ROUTER
protocol ChristmasRouterProtocol: AnyObject {
    func pushToDetail(from: ChristmasViewProtocol?, id: Int)
}
