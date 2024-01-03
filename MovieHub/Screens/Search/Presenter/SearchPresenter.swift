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
    
    internal var searchSections: [SearchSection] = []
    
    //MARK: Select category
    func selectedCategory(_ index: Int, genre: MovieGenre) {
        interactor?.selectedCategory(index)
        interactor?.requestUpcomingMovie(category: genre)
    }
    
    //MARK: - Get models
    
    func getCategories() -> [CategoryModel] {
        guard let interactor = interactor else { return [CategoryModel]() }
        return interactor.categoriesData
    }
    
    func getUpcomingMovie() -> [Doc] {
        guard let model = interactor?.upcomingMovie else { return [Doc]() }
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
