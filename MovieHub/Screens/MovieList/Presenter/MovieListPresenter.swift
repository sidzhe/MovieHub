//
//  MovieListPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class MovieListPresenter: MovieListPresenterProtocol {
    
    //MARK: Properties
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorInputProtocol?
    var router: MovieListRouterProtocol?
    
    //MARK: Get movies
    func getMovies() -> [Doc] {
        guard let model = interactor?.moviesData?.docs else { return [Doc]() }
        return model
    }
    
    func getCategories() -> [CategoryModel] {
        guard let model = interactor?.cagegoriesData else { return [CategoryModel]() }
        return model
    }
    
    //MARK: Select category
    func selectedCategory(_ index: Int, genre: MovieGenre) {
        interactor?.selectedCategory(index)
        interactor?.requestMovies(genre: genre)
    }
    
    //MARK: Route to
    func routeToDetail() {
        
    }
}


//MARK: - Extension MovieListInteractorOutputProtocol
extension MovieListPresenter: MovieListInteractorOutputProtocol {

    func updateUI() {
        view?.updateUI()
    }
    
    func getError(_ error: String) {
        view?.displayError(error)
    }
}
