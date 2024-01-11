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
    func updateUI(model: [SearchModel]?)
    func displayRequestError(error: String)
}

/// VIEW -> PRESENTER
protocol WishlistPresenterProtocol: AnyObject {
    var view: WishlistViewProtocol? { get set }
    func getWishListData()
}

/// PRESENTER -> INTERACTOR
protocol WishlistInteractorInputProtocol: AnyObject {
    var presenter: WishlistInteractorOutputProtocol? { get set }
    var wishListMovieData: [SearchModel]? {get}
    func startFetchWishListData()
}

/// INTERACTOR -> PRESENTER
protocol WishlistInteractorOutputProtocol: AnyObject {
    func updateUI(model: [SearchModel]?)
    func showError(error: Error)
}

/// PRESENTER -> ROUTER
protocol WishlistRouterProtocol: AnyObject {
    
}
