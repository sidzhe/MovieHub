//
//  MainPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
    
    //MARK: Properties
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    //MARK: Requests
    func fetch() {
        interactor?.requestCollection()
    }
    
    func fetchSearchRequest(_ title: String) {
        interactor?.requestSearch(title)
    }
    
    //MARK: - Get models
    func getColletionModel() -> [DocCollect] {
        guard let model = interactor?.collectionData?.docs else { return [DocCollect]() }
        return model
    }
    
    func getCategories() -> [CategoryModel] {
        guard let interactor = interactor else { return [CategoryModel]() }
        return interactor.cagegoriesData
    }
    
    func getMostPopular() -> [Doc] {
        guard let model = interactor?.mostPopular?.docs else { return [Doc]() }
        return model 
    }
    
    func getSearchData() -> [Doc] {
        guard let model = interactor?.searchData?.docs else { return [Doc]() }
        return model
    }
    
    //MARK: Select category
    func selectedCategory(_ index: Int, genre: MovieGenre) {
        interactor?.selectedCategory(index)
        interactor?.requestMostRating(genre: genre)
    }
    
    //MARK: Route to
    func routeToMovieList() {
        guard let view = view else { return }
        router?.pushToMovieList(from: view)
    }
    
    func routeToPupularMovie() {
        guard let view = view else { return }
        router?.pushToPopularMovie(from: view)
    }
    
    func routeToDetail() {
        guard let view = view else { return }
        router?.pushToDetail(from: view)
    }
    
    func routeToWishList() {
        guard let view = view else { return }
        router?.pushToWishList(from: view)
    }
}


//MARK: - Extension MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    func updateUI() {
        view?.updateUI()
    }
    
    func getError(error: RequestError) {
        view?.displayRequestError(error: error)
    }
}
