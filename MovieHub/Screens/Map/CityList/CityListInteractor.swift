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
    private let networkService: NetworkServiceProtocol
    private let storageService: StorageServiceProtool
    var cityList = CityListModel.allCases.map { $0.rawValue.localized() }
    var filteredCity: [String]?
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol, storageService: StorageServiceProtool) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    //MARK: Saving the current city to CoreData
    func saveCurrentCityToCD(city: String) {
        storageService.saveCurrentCity(name: city)
    }
}
