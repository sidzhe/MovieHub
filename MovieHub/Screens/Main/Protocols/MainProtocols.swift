//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol MainViewProtocol: AnyObject {
    var presenter: MainPresenterProtocol? { get set }
    func updateUI()
}

/// VIEW -> PRESENTER
protocol MainPresenterProtocol: AnyObject {
    var view: MainViewProtocol? { get set }
    func fetch()
    func getColletionModel() -> [DocCollect]
    func getCategories() -> [CategoryModel]
    func getMostPopular() -> [Doc]
    func getSearchData() -> [Doc]
    func selectedCategory(_ index: Int, genre: MovieGenre)
    func fetchSearchRequest(_ title: String)
}

/// PRESENTER -> INTERACTOR
protocol MainInteractorInputProtocol: AnyObject {
    var presenter: MainInteractorOutputProtocol? { get set }
    var collectionData: ColletionModel? { get }
    var cagegoriesData: [CategoryModel] { get }
    var mostPopular: CollectionDetailModel? { get }
    var searchData: SearchModel? { get }
    func requestCollection()
    func requestMostRating(genre: MovieGenre)
    func requestSearch(_ title: String)
    func selectedCategory(_ index: Int)
}

/// INTERACTOR -> PRESENTER
protocol MainInteractorOutputProtocol: AnyObject {
    func updateUI()
}

/// PRESENTER -> ROUTER
protocol MainRouterProtocol: AnyObject {
    
}
