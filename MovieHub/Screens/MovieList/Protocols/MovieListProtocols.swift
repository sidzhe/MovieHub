//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol MovieListViewProtocol: AnyObject {
    var presenter: MovieListPresenterProtocol? { get set }
    func updateUI()
    func displayError(_ error: String)
}

/// VIEW -> PRESENTER
protocol MovieListPresenterProtocol: AnyObject {
    var view: MovieListViewProtocol? { get set }
    func getMovies() -> [Doc]
    func getCategories() -> [CategoryModel]
    func selectedCategory(_ index: Int, genre: MovieGenre)
    func routeToDetail()
    
}

/// PRESENTER -> INTERACTOR
protocol MovieListInteractorInputProtocol: AnyObject {
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var cagegoriesData: [CategoryModel] { get }
    var moviesData: CollectionDetailModel? { get }
    func selectedCategory(_ index: Int)
    func requestMovies(genre: MovieGenre)
}

/// INTERACTOR -> PRESENTER
protocol MovieListInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getError(_ error: String)
}

/// PRESENTER -> ROUTER
protocol MovieListRouterProtocol: AnyObject {
    
}
