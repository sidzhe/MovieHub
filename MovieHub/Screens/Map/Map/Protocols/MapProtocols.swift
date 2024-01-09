//
//  MapProtocols.swift
//  MovieHub
//
//  Created by sidzhe on 05.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol MapViewProtocol: AnyObject {
    var presenter: MapPresenterProtocol? { get set }
    func addPinsToMap()
}

/// VIEW -> PRESENTER
protocol MapPresenterProtocol: AnyObject {
    var view: MapViewProtocol? { get set }
    func getSelectedLocation() -> Location
    func getUserLocation() -> Location
    func makePinsData() -> [Datum]
    func convertCinema(name: String?) -> String
}

/// PRESENTER -> INTERACTOR
protocol MapInteractorInputProtocol: AnyObject {
    var presenter: MapInteractorOutputProtocol? { get set }
    var userLocation: Location { get }
    var selectedCityLocation: Location { get }
    var cityList: [Datum]? { get }
}

/// INTERACTOR -> PRESENTER
protocol MapInteractorOutputProtocol: AnyObject {
    func addPins()
}

/// PRESENTER -> ROUTER
protocol MapRouterProtocol: AnyObject {

}
