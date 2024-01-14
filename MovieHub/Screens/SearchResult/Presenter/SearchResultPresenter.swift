//
//  SearchResultPresenter.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 09.01.2024.
//

import Foundation

final class SearchResultPresenter: SearchResultPresenterProtocol {
    
    //MARK: Properties
    weak var view: SearchResultViewProtocol?
    var interactor: SearchResultInteractorInputProtocol?
    var router: SearchResultRouterProtocol?
    
    //MARK: - updateSearchResults
    func updateSearchResults(with searchText: String) {
        interactor?.requestPerson(name: searchText)
        interactor?.requestSearch(searchText)
    }
    
    //MARK: - Get models
    func getSearchMovie() -> [Doc] {
        guard let model = interactor?.searchMovie?.docs else { return [Doc]() }
        let filteredModel = model.filter { $0.poster?.url != Constant.none || (($0.poster?.previewURL) != nil) }
        return filteredModel
    }
    
    func getSearchPerson() -> [DocPerson] {
        guard let model = interactor?.searchPerson?.docs else { return [DocPerson]() }
        let filteredModel = model.filter { $0.name != Constant.none && $0.photo != Constant.none }
        return filteredModel
    }
    
    //MARK: - RouteTo
    func routeToDetail(with movieId: String) {
        router?.pushToDetail(from: view, movieId: movieId)
    }
    
    func routeToPersonDetail(with personId: Int) {
        let personId = getSearchPerson()[personId].id
        router?.pushToPersonDetail(from: view, personId: personId)
    }
    
    
}

//MARK: - Extension SearchResultInteractorOutputProtocol
extension SearchResultPresenter: SearchResultInteractorOutputProtocol {
    
    func getError(error: RequestError) {
        view?.displayRequestError(error: error)
    }
    
    func updateUI() {
        view?.updateUI()
    }
}
