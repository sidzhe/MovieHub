//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol SearchViewProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
    func updateUI()
    func displayRequestError(error: RequestError)
}

/// VIEW -> PRESENTER
protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol? { get set }
   
    func getUpcomingMovie() -> [Doc]
    func getRecentMovie() -> [Doc]
    func getCategories() -> [String]
    
    func fetchUpcomingMovie(with genre: String)
    
    func routeToDetail(with movieId: Int)
}

/// PRESENTER -> INTERACTOR
protocol SearchInteractorInputProtocol: AnyObject {
    var presenter: SearchInteractorOutputProtocol? { get set }
    
    var categories: [String] { get }
    var upcomingMovie: SearchModel? { get }
    var recentMovie: SearchModel? { get }
    
    func getRecentMovieIds() -> [String]
    
    func requestUpcomingMovie(category: MovieGenre)
    func requestRecentMovies(with moviesId: [String])

}

/// INTERACTOR -> PRESENTER
protocol SearchInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getError(error: RequestError)
}

/// PRESENTER -> ROUTER
protocol SearchRouterProtocol: AnyObject {
    func pushToDetail(from view: SearchViewProtocol?, movieId: Int)

}
