//
//  SearchPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class SearchPresenter: SearchPresenterProtocol {
    func getCategories() -> [SearchCategoryModel] {
        guard let interactor = interactor else { return [SearchCategoryModel]() }
        return interactor.searchCategoriesData
    }
    
    func getRecentMovie() -> [Doc] {
        let recent:[Doc] = []
        return recent
    }
    
    func getSearchData() -> [Doc] {
        guard let model = interactor?.searchMovie?.docs else { return [Doc]() }
        return model
    }
    
    func selectedCategory(_ index: Int, genre: MovieGenre) {
        interactor?.selectedCategory(index)
       // interactor?.requestMostRating(genre: genre)
    }
    
    
    //MARK: Properties
    weak var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    
}


//MARK: - Extension SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {
    
}
