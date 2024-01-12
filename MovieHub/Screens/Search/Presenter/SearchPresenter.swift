//
//  SearchPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    
    
    //MARK: Properties
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    
    //MARK: - Fetch
    func fetchUpcomingMovie(with genre: String) {
        interactor?.requestUpcomingMovie(category: MovieGenre(rawValue: genre) ?? .all)
    }
    
    //MARK: - Get models
    func getCategories() -> [String] {
        guard let model = interactor?.categories else { return [] }
        return model
    }
    
    func getUpcomingMovie() -> [Doc] {
        guard let model = interactor?.upcomingMovie?.docs else { return [Doc]() }
        let filteredModel = model.filter { $0.poster?.url != "" || (($0.poster?.previewURL) != nil) }
        
        return filteredModel
        return model
    }
    
    func getRecentMovie() -> [Doc] {
#warning("добавить логику")
        let recent:[Doc] = []
        return recent
    }
    //MARK: - Route
    func routeToDetail(with movieId: Int ) {
        router?.pushToDetail(from: view, movieId: movieId)
    }
}

//MARK: - Extension SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {
    
    func getError(error: RequestError) {
        view?.displayRequestError(error: error)
    }
    
    func updateUI() {
        view?.updateUI()
    }
}
