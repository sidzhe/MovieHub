//
//  GlobeProtocols.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol GlobeViewProtocol: AnyObject {
    var presenter: GlobePresenterProtocol? { get set }
    func updateUI()
    func displayErrorMessage(_ message: String)
}

/// VIEW -> PRESENTER
protocol GlobePresenterProtocol: AnyObject {
    var view: GlobeViewProtocol? { get set }
    func getCinemaData() -> [GlobeCinema]
    func getCurrentCity() -> String
    func filteredText(with filter: String?) -> [GlobeCinema]
    func loadCurrentCity()
    func routeToMap()
    func routeToCinemaDetail(index: Int)
    func routeToCityList()
}

/// PRESENTER -> INTERACTOR
protocol GlobeInteractorInputProtocol: AnyObject {
    var presenter: GlobeInteractorOutputProtocol? { get set }
    var cinemaData: [Datum]? { get }
    var currentLocation: Location { get }
    var currentCity: String { get }
    var selectedCityLocation: Location? { get }
    func loadCurrentCity()
}

/// INTERACTOR -> PRESENTER
protocol GlobeInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getRequestError(_ error: String)
}

/// PRESENTER -> ROUTER
protocol GlobeRouterProtocol: AnyObject {
    func pushToMap(from view: GlobeViewProtocol?, cityName: String, userLocation: Location, selectedCityLocation: Location)
    func pushToCinemaList(from view: GlobeViewProtocol?, globeCinema: GlobeCinema)
    func pushToCityList(from view: GlobeViewProtocol?)
}
