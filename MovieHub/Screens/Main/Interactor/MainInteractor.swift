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
    var networkService: NetworkServiceProtool
    var collectionData: ColletionModel?
    var cagegoriesData = MovieGenre.allCases.map { CategoryModel(category: $0.rawValue) }
    var mostPopular: CollectionDetailModel?
    var searchData: SearchModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtool) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func selectedCategory(_ index: Int) {
        cagegoriesData.enumerated().forEach { cagegoriesData[$0.offset].isSelected = false }
        cagegoriesData[index].isSelected = !cagegoriesData[index].isSelected
        presenter?.updateUI()
    }
    
    func requestCollection() {
        networkService.searchColletions { [weak self] (result: (Result<ColletionModel, RequestError>)) in
            switch result {
                
            case .success(let collection):
                self?.collectionData = collection
                self?.presenter?.updateUI()
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
    
    func requestMostRating(genre: MovieGenre) {
        networkService.getRateCollection(genre: genre) { [weak self] (result: (Result<CollectionDetailModel, RequestError>)) in
            switch result {
                
            case .success(let collection):
                self?.mostPopular = collection
                self?.presenter?.updateUI()
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
    
    func requestSearch(_ title: String) {
        
        guard !title.isEmpty else {
            self.searchData = nil
            self.presenter?.updateUI()
            return
        }
        
        networkService.searchTitle(title) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            switch result {
                
            case .success(let search):
                self?.searchData = search
                self?.presenter?.updateUI()
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}
