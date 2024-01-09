//
//  MapPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 05.01.2024.
//

import Foundation

final class MapPresenter: MapPresenterProtocol {

    //MARK: Properties
    weak var view: MapViewProtocol?
    var interactor: MapInteractorInputProtocol?
    var router: MapRouterProtocol?
    
    //MARK: Methods
    func getSelectedLocation() -> Location {
        guard let location = interactor?.selectedCityLocation else { return Location(lat: 0, lon: 0) }
        return location
    }
    
    func getUserLocation() -> Location {
        guard let location = interactor?.userLocation else { return Location(lat: 0, lon: 0) }
        return location
    }
    
    func makePinsData() -> [Datum] {
        guard let data = interactor?.cityList else { return [Datum]() }
        return data
    }
    
    func convertCinema(name: String?) -> String {
        guard let name = name else { return "" }
        let regex = try? NSRegularExpression(pattern: "Кинотеатр |Киноцентр |«|»", options: .caseInsensitive)
        let range = NSRange(location: 0, length: name.utf16.count)
        let cleanedCinema = regex?.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: "")
        return cleanedCinema ?? name
    }
}


//MARK: - Extension MapInteractorOutputProtocol
extension MapPresenter: MapInteractorOutputProtocol {
    func addPins() {
        view?.addPinsToMap()
    }
}
