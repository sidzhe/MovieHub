//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

/// PRESENTER -> VIEW
protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func updateUI()
    func displayRequestError(error: String)
    func updateProfileInfo(user: UserEntity)
}

/// VIEW -> PRESENTER
protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    func getUserInfo()
    func fetch()
    func getColletionModel() -> [DocCollect]
    func getCategories() -> [CategoryModel]
    func getMostPopular() -> [Doc]
    func getSearchData() -> [Doc]
    func checkCurrentUser() -> Bool
    func selectedCategory(_ index: Int, genre: MovieGenre)
    func fetchSearchRequest(_ title: String)
    func routeToMovieList()
    func routeToPupularMovie()
    func routeToDetail(index: Int)
    func routeToDetailFromSearch(index: Int)
    func routeToWishList()
    func routeToGlobe()
    func routeToCollection(_ index: Int)
    func sendMyLocation(lat: Double, lon: Double, cityName: String)
}

/// PRESENTER -> INTERACTOR
protocol MainInteractorInputProtocol: AnyObject {
    var presenter: MainInteractorOutputProtocol? { get set }
    
    var collectionData: ColletionModel? { get }
    var cagegoriesData: [CategoryModel] { get }
    var mostPopular: CollectionDetailModel? { get }
    var searchData: SearchModel? { get }
    func checkCurrentUser() -> Bool
    func requestCollection()
    func requestMostRating(genre: MovieGenre)
    func requestSearch(_ title: String)
    func selectedCategory(_ index: Int)
    func saveCurrentLocation(lat: Double, lon: Double, cityName: String)
    func getUserLocation() -> (lat: Double, lon: Double, currentCity: String)
    func getUserInfo() -> Result<UserEntity, Error>
}

/// INTERACTOR -> PRESENTER
protocol MainInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getError(error: String)
}

/// PRESENTER -> ROUTER
protocol MainRouterProtocol: AnyObject {
    func pushToMovieList(from view: MainViewProtocol?)
    func pushToPopularMovie(from view: MainViewProtocol?)
    func pushToDetail(from view: MainViewProtocol?, detailId: Int)
    func pushToWishList(from view: MainViewProtocol?)
    func pushToGlobe(from view: MainViewProtocol?, lat: Double, lon: Double, currentCity: String)
    func pushToCollection(from view: MainViewProtocol?, slug: String)
}
