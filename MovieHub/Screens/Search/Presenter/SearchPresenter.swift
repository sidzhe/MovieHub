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
    var categories: MovieGenre.AllCases = MovieGenre.allCases
    
    //MARK: - Fetch
    func fetchUpcomingMovie(with genre: MovieGenre) {
        interactor?.requestUpcomingMovie(category: genre)
    }
    
    func fetchSearchedMovie(with searchText: String) {
        interactor?.requestSearch(searchText)
    }
    
    //MARK: - Get models
    func getUpcomingMovie() -> [UpcomingDoc] {
        guard let model = interactor?.upcomingMovie?.docs else { return [UpcomingDoc]() }
        return model
    }

    func getRecentMovie() -> [Doc] {
#warning("добавить логику")
        let recent:[Doc] = []
        return recent
    }
    
    func getSearchData() -> [Doc] {
        guard let model = interactor?.searchMovie?.docs else { return [Doc]() }
        return model
    }
}


//MARK: - Extension SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {
    func updateUI() {
        view?.updateUI()
    }
}
