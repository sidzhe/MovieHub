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
    func removeItemFromCollection(at indexPath: IndexPath)
}

/// VIEW -> PRESENTER
protocol WishlistPresenterProtocol: AnyObject {
    var view: WishlistViewProtocol? { get set }
    func getWishListData() -> [Doc]
    func updateModel()
    func removeItem(at indexPath: IndexPath) 
    func routeToDetail(index: Int)
}

/// PRESENTER -> INTERACTOR
protocol WishlistInteractorInputProtocol: AnyObject {
    var presenter: WishlistInteractorOutputProtocol? { get set }
    var favoriteModel: [Doc]? { get set }
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
