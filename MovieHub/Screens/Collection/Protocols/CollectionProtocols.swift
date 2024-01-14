//
//  CollectionProtocols.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol CollectionViewProtocol: AnyObject {
    var presenter: CollectionPresenterProtocol? { get set }
    func updateUI()
    func displayError(_ error: String)
}

/// VIEW -> PRESENTER
protocol CollectionPresenterProtocol: AnyObject {
    var view: CollectionViewProtocol? { get set }
    func getCollectionModel() -> [Doc]
    func routeToDetail()
}

/// PRESENTER -> INTERACTOR
protocol CollectionInteractorInputProtocol: AnyObject {
    var presenter: CollectionInteractorOutputProtocol? { get set }
    var collectionData: SearchModel? { get }
}

/// INTERACTOR -> PRESENTER
protocol CollectionInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getError(_ error: String)
}

/// PRESENTER -> ROUTER
protocol CollectionRouterProtocol: AnyObject {
    func pushToDetail(from view: CollectionViewProtocol?)
}
