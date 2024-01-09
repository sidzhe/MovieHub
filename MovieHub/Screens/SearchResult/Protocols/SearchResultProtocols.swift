//
//  SearchResultProtocols.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 09.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol SearchResultViewProtocol: AnyObject {
    var presenter: SearchResultPresenterProtocol? { get set }
    func updateUI()
    func displayRequestError(error: RequestError)
}

/// VIEW -> PRESENTER
protocol SearchResultPresenterProtocol: AnyObject {
    var view: SearchResultViewProtocol? { get set }
    
    func updateSearchResults(with searchText: String?)
    
    func getSearchPerson() -> [DocPerson]
    func getSearchMovie() -> [Doc]
}

/// PRESENTER -> INTERACTOR
protocol SearchResultInteractorInputProtocol: AnyObject {
    var presenter: SearchResultInteractorOutputProtocol? { get set }
    
    var searchPerson: PersonModel? { get }
    var searchMovie: SearchModel? { get }
  
    func requestSearch(_ title: String)
    func requestPerson(name: String)
}

/// INTERACTOR -> PRESENTER
protocol SearchResultInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getError(error: RequestError)
}

/// PRESENTER -> ROUTER
protocol SearchResultRouterProtocol: AnyObject {
    
}
