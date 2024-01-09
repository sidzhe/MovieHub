//
//  GlobePresenter.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation
import CoreLocation

final class GlobePresenter: GlobePresenterProtocol {
    
    //MARK: Properties
    weak var view: GlobeViewProtocol?
    var interactor: GlobeInteractorInputProtocol?
    var router: GlobeRouterProtocol?
    
    //MARK: Get model methods
    func getCurrentCity() -> String {
        guard let city = interactor?.currentCity else { return "" }
        return city
    }
    
    func getCinemaData() -> [GlobeCinema] {
        guard let model = interactor?.cinemaData, let myLocation = interactor?.currentLocation else { return [GlobeCinema]() }
        
        var globeCinemaModel = [GlobeCinema]()
        
        model.forEach { element in
            let name = element.data?.general?.name ?? ""
            let adress = element.data?.general?.address?.street ?? ""
            let lat = element.data?.general?.address?.mapPosition?.coordinates?[1] ?? 0.0
            let lon = element.data?.general?.address?.mapPosition?.coordinates?[0] ?? 0.0
            let cinemaLocation = Location(lat: lat, lon: lon)
            let distance = calculateDistance(myLocation: myLocation, pointLocation: cinemaLocation)
            let image = element.data?.general?.gallery?.compactMap({ $0.url })
            let description = element.data?.general?.description
            let phone = element.data?.general?.contacts?.phones?.first?.value
            let globeCinemaElement = GlobeCinema(
                distance: distance,
                name: name,
                adress: adress,
                image: image,
                description: description,
                phone: phone)
            globeCinemaModel.append(globeCinemaElement)
        }
        
        return globeCinemaModel.sorted(by: { $0.distance < $1.distance })
    }
    
    func loadCurrentCity() {
        interactor?.loadCurrentCity()
    }
    
    //MARK: Calculete distance
    private func calculateDistance(myLocation: Location, pointLocation: Location) -> Double {
        let myCoordinate = CLLocationCoordinate2D(latitude: myLocation.lat, longitude: myLocation.lon)
        let pointCoordinate = CLLocationCoordinate2D(latitude: pointLocation.lat, longitude: pointLocation.lon)
        let myLocation = CLLocation(latitude: myCoordinate.latitude, longitude: myCoordinate.longitude)
        let pointLocation = CLLocation(latitude: pointCoordinate.latitude, longitude: pointCoordinate.longitude)
        let distanceInMeters = myLocation.distance(from: pointLocation)
        let distanceInKilometers = distanceInMeters / 1000.0
        return distanceInKilometers
    }
    
    //MARK: Filter text
    func filteredText(with filter: String?) -> [GlobeCinema] {
        let cinemaData = getCinemaData()
        guard let filter = filter, !filter.isEmpty else { return cinemaData }
        let data = cinemaData.filter({ $0.name.contains(filter) || $0.adress.contains(filter) })
        return data
    }
    
    //MARK: Route to
    func routeToMap() {
        guard let selectedCityLocation = interactor?.selectedCityLocation,
              let userLocation = interactor?.currentLocation else { return }
        let currentCity = getCurrentCity()
        router?.pushToMap(from: view, cityName: currentCity, userLocation: userLocation, selectedCityLocation: selectedCityLocation)
    }
    
    func routeToCinemaDetail(index: Int) {
        let sortedModel = getCinemaData()[index]
        router?.pushToCinemaList(from: view, globeCinema: sortedModel)
    }
    
    func routeToCityList() {
        router?.pushToCityList(from: view)
    }
}


//MARK: - Extension GlobeInteractorOutputProtocol
extension GlobePresenter: GlobeInteractorOutputProtocol {
    func updateUI() {
        view?.updateUI()
    }
    
    func getRequestError(_ error: String) {
        view?.displayErrorMessage(error)
    }
}
