//
//  GlobeInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation

final class GlobeInteractor: GlobeInteractorInputProtocol {
    
    //MARK: Properties
    weak var presenter: GlobeInteractorOutputProtocol?
    private let networkService: NetworkServiceProtocol
    private let storageService: StorageServiceProtool
    var currentCity: String
    var currentLocation: Location
    var selectedCityLocation: Location?
    var cinemaData: [Datum]?
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol, storageService: StorageServiceProtool, lat: Double, lon: Double, city: String) {
        self.networkService = networkService
        self.storageService = storageService
        self.currentCity = city
        self.currentLocation = Location(lat: lat, lon: lon)
        self.saveCityName()
        self.cityListRequest()
    }
    
    //MARK: City list request
    func cityListRequest() {
        networkService.getCityList(city: currentCity) { [weak self] (result: (Result<CinemaModel, RequestError>)) in
            
            switch result{
            case .success(let cinema):
                self?.cinemaData = cinema.data
                self?.presenter?.updateUI()
            case .failure(let error):
                self?.presenter?.getRequestError(error.customMessage)
            }
        }
    }
    
    //MARK: Get coordinate from selected or current city
    func getCityCoordinate() {
        networkService.getCurrentCity(city: currentCity) { [weak self] (result: (Result<CurrentCityModel, RequestError>)) in
            
            switch result {
            case .success(let data):
                let data = data.response?.geoObjectCollection?.featureMember?.first?.geoObject?.point?.pos
                let newLocation = data?.components(separatedBy: " ")
                let lat = Double(newLocation?[1] ?? "0") ?? 0
                let lon = Double(newLocation?[0] ?? "0") ?? 0
                self?.selectedCityLocation = Location(lat: lat, lon: lon)
            case .failure(let error):
                self?.presenter?.getRequestError(error.customMessage)
            }
        }
    }
    
    //MARK: Load from CoreData
    func loadCurrentCity() {
        self.currentCity = storageService.loadCurrnetCity()
        cityListRequest()
        getCityCoordinate()
    }
    
    //MARK: Saving the current city to CoreData
    func saveCityName() {
        storageService.saveCurrentCity(name: currentCity)
    }
}
