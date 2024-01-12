//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol WishlistViewProtocol: AnyObject {
    var presenter: WishlistPresenterProtocol? { get set }
    func updateUI()
    func displayRequestError(error: String)
}

/// VIEW -> PRESENTER
protocol WishlistPresenterProtocol: AnyObject {
    var view: WishlistViewProtocol? { get set }
    func getWishListData() -> [Doc]
    func updateModel()
    func checkWishElement(id: Int)
    func routeToDetail(index: Int)
}

/// PRESENTER -> INTERACTOR
protocol WishlistInteractorInputProtocol: AnyObject {
    var presenter: WishlistInteractorOutputProtocol? { get set }
    var favoriteModel: SearchModel? { get }
    func updateWishModel()
    func checkWishElement(id: Int)
}

/// INTERACTOR -> PRESENTER
protocol WishlistInteractorOutputProtocol: AnyObject {
    func updateUI()
    func showError(error: Error)
}

/// PRESENTER -> ROUTER
protocol WishlistRouterProtocol: AnyObject {
    func pushToDetail(from: WishlistViewProtocol?, id: Int)
}
