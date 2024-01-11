//
//  MainInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class MainInteractor: MainInteractorInputProtocol {

    //MARK: - Properties
    weak var presenter: MainInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol
    var collectionData: ColletionModel?
    var cagegoriesData = MovieGenre.allCases.map { CategoryModel(category: $0.rawValue) }
    var mostPopular: CollectionDetailModel?
    var searchData: SearchModel?
    var lat: Double?
    var lon: Double?
    var currentCity: String?
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func selectedCategory(_ index: Int) {
        cagegoriesData.enumerated().forEach { cagegoriesData[$0.offset].isSelected = false }
        cagegoriesData[index].isSelected = !cagegoriesData[index].isSelected
        presenter?.updateUI()
    }
    
    //MARK: Save user location
    func saveCurrentLocation(lat: Double, lon: Double, cityName: String) {
        self.lat = lat
        self.lon = lon
        self.currentCity = cityName
    }
    
    //MARK: Get user location
    func getUserLocation() -> (lat: Double, lon: Double, currentCity: String) {
        guard let lat = lat, let lon = lon, let currentCity = currentCity else { return (0, 0, "Москва") }
        return (lat, lon, currentCity)
    }
    
    //MARK: Requests
    func requestCollection() {
        networkService.searchColletions { [weak self] (result: (Result<ColletionModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
                
            case .success(let collection):
                self.collectionData = collection
                self.presenter?.updateUI()
            case .failure(let error):
                self.presenter?.getError(error: error.customMessage)
            }
        }
    }
    
    func requestMostRating(genre: MovieGenre) {
        networkService.getRateCollection(genre: genre) { [weak self] (result: (Result<CollectionDetailModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
                
            case .success(let collection):
                self.mostPopular = collection
                self.presenter?.updateUI()
            case .failure(let error):
                self.presenter?.getError(error: error.customMessage)
            }
        }
    }
    
    func requestSearch(_ title: String) {
        
        guard !title.isEmpty else {
            searchData = nil
            presenter?.updateUI()
            return
        }
        
        networkService.searchMovieByTitle(title) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
                
            case .success(let search):
                self.searchData = search
                self.presenter?.updateUI()
            case .failure(let error):
                self.presenter?.getError(error: error.customMessage)
            }
        }
    }
}
