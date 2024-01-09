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
        router?.pushToMovieList(from: view)
    }
    
    func routeToPupularMovie() {
        router?.pushToPopularMovie(from: view)
    }
    
    func routeToDetail() {
        router?.pushToDetail(from: view)
    }
    
    func routeToWishList() {
        router?.pushToWishList(from: view)
    }
    
    func routeToGlobe() {
        guard let coordinate = interactor?.getUserLocation() else { return }
        router?.pushToGlobe(from: view, lat: coordinate.lat, lon: coordinate.lon, currentCity: coordinate.currentCity)
    }
    
    //MARK: Send current user location
    func sendMyLocation(lat: Double, lon: Double, cityName: String) {
        interactor?.saveCurrentLocation(lat: lat, lon: lon, cityName: cityName)
    }
}


//MARK: - Extension MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    func updateUI() {
        view?.updateUI()
    }
    
    func getError(error: String) {
        view?.displayRequestError(error: error)
    }
}
