//
//  MapInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 05.01.2024.
//

import Foundation

final class MapInteractor: MapInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: MapInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol
    var cityList: [Datum]?
    var userLocation: Location
    var selectedCityLocation: Location
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol, 
         currentCity: String,
         userLocation: Location,
         selectedCityLocation: Location) {
        self.networkService = networkService
        self.userLocation = userLocation
        self.selectedCityLocation = selectedCityLocation
        self.getCity(with: currentCity)
    }
    
    //MARK: Get cinema from current city
    func getCity(with name: String) {
        networkService.getCityList(city: name) { [weak self] (result: (Result<CinemaModel, RequestError>)) in
    
            switch result {
            case .success(let cinema):
                self?.cityList = cinema.data
                self?.presenter?.addPins()
            case .failure(let error):
                self?.presenter?.getError(error.customMessage)
            }
        }
    }
}
