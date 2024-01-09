//
//  CityListInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 07.01.2024.
//

import Foundation

final class CityListInteractor: CityListInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: CityListInteractorOutputProtocol?
    private let networkService: NetworkServiceProtool
    private let storageService: StorageServiceProtool
    var cityList = CityListModel.allCases.map { $0.rawValue }
    var filteredCity: [String]?
    
    init(networkService: NetworkServiceProtool, storageService: StorageServiceProtool) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    //MARK: Methods
    func saveCurrentCityToCD(city: String) {
        storageService.saveCurrentCity(name: city)
    }
}
