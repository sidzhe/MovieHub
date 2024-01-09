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
}

/// VIEW -> PRESENTER
protocol WishlistPresenterProtocol: AnyObject {
    var view: WishlistViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol WishlistInteractorInputProtocol: AnyObject {
    var presenter: WishlistInteractorOutputProtocol? { get set }
    var favoriteMoviesID: [Int] {get}
    func requestFavoriteMovies()
}

/// INTERACTOR -> PRESENTER
protocol WishlistInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol WishlistRouterProtocol: AnyObject {
    
}
