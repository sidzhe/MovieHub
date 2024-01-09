//
//  CityListProtocols.swift
//  MovieHub
//
//  Created by sidzhe on 07.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol CityListViewProtocol: AnyObject {
    var presenter: CityListPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol CityListPresenterProtocol: AnyObject {
    var view: CityListViewProtocol? { get set }
    func getCityList() -> [String]
    func filteredCity(with filter: String?) -> [String]
    func getFilteredCity() -> [String]
    func saveSelectedCity(name: String)
    func routeToPrevious()
}

/// PRESENTER -> INTERACTOR
protocol CityListInteractorInputProtocol: AnyObject {
    var cityList: [String] { get }
    var filteredCity: [String]? { get set }
    var presenter: CityListInteractorOutputProtocol? { get set }
    func saveCurrentCityToCD(city: String)
}

/// INTERACTOR -> PRESENTER
protocol CityListInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol CityListRouterProtocol: AnyObject {
    func pushBack(view: CityListViewProtocol?)
}
