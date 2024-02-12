//
//  SearchResultProtocols.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 09.01.2024.
//

import UIKit

/// PRESENTER -> VIEW
protocol SearchResultViewProtocol: AnyObject {
    var presenter: SearchResultPresenterProtocol? { get set }
    var parentNavigationController: UINavigationController? { get set }
    func updateUI()
    func displayRequestError(error: RequestError)
    
}

/// VIEW -> PRESENTER
protocol SearchResultPresenterProtocol: AnyObject {
    var view: SearchResultViewProtocol? { get set }
    
    func updateSearchResults(with searchText: String)
    
    func getSearchPerson() -> [DocPerson]
    func getSearchMovie() -> [Doc]
    
    func routeToDetail(index: Int)
    func routeToPersonDetail(with personId: Int)
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
    func pushToDetail(from view: SearchResultViewProtocol?, id: Int)
    func pushToPersonDetail(from view: SearchResultViewProtocol?, personId: Int)
}
