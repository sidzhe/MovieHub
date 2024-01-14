//
//  TrailerProtocols.swift
//  MovieHub
//
//  Created by sidzhe on 13.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol TrailerViewProtocol: AnyObject {
    var presenter: TrailerPresenterProtocol? { get set }
    func displayError(_ error: String)
    func updateUI()
}

/// VIEW -> PRESENTER
protocol TrailerPresenterProtocol: AnyObject {
    var view: TrailerViewProtocol? { get set }
    func getPerson() -> [Person]?
    func getImages() -> [GaleryDoc]
    func makeTrailerId() -> String 
    func rotueToDetail(at indexPath: IndexPath)
}

/// PRESENTER -> INTERACTOR
protocol TrailerInteractorInputProtocol: AnyObject {
    var presenter: TrailerInteractorOutputProtocol? { get set }
    var detailModel: DetailModel? { get }
    var urlImages: [GaleryDoc]? { get }
}

/// INTERACTOR -> PRESENTER
protocol TrailerInteractorOutputProtocol: AnyObject {
    func getError(_ error: String)
    func updateUI()
}

/// PRESENTER -> ROUTER
protocol TrailerRouterProtocol: AnyObject {
    func pushToDetail(from view: TrailerViewProtocol?, detailId: Int)
}
