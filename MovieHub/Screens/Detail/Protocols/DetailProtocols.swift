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
    func updateUI()
    func displayRequestError(_ error: RequestError)
}

/// VIEW -> PRESENTER
protocol DetailPresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    func getDetailData() -> DetailModel?
    func checkFavorites()
    func getFavoritesButtonState() -> Bool
    func addRecentMovie()
    func routeToTrailer()
}

/// PRESENTER -> INTERACTOR
protocol DetailInteractorInputProtocol: AnyObject {
    var presenter: DetailInteractorOutputProtocol? { get set }
    var detailData: DetailModel? { get }
    func checkFavorites(id: Int)
    func getFavoritesButtonState() -> Bool
    func addRecentMovie()
}

/// INTERACTOR -> PRESENTER
protocol DetailInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getRequestError(_ error: RequestError)
}

/// PRESENTER -> ROUTER
protocol DetailRouterProtocol: AnyObject {
    func pushToTrailer(from view: DetailViewProtocol?, detailModel: DetailModel)
}
