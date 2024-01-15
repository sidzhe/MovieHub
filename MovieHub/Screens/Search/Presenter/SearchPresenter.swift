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
    
    func fetchRecentMovie() {
        guard let movieIds = interactor?.getRecentMovieIds() else { return }
        interactor?.requestRecentMovies(with: movieIds)
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
    }
    
    func getRecentMovie() -> [Doc] {
        guard let model = interactor?.recentMovie?.docs else { return [Doc]() }
        print(model)
        return model
    }

    //MARK: - Route
    func routeToDetail(with index: Int ) {
        guard let id = getUpcomingMovie()[index].id else { return }
        router?.pushToDetail(from: view, Id: id)
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
