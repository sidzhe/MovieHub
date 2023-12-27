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
    var cagegoriesData = MovieGenre.allCases.map { $0.rawValue }
    var mostPopular: CollectionDetailModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtool) {
        self.networkService = networkService
    }
    
    //MARK: Methods
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
    
    func requestMostRating() {
        networkService.getRateCollection(genre: .drama) { [weak self] (result: (Result<CollectionDetailModel, RequestError>)) in
            switch result {
                
            case .success(let collection):
                self?.mostPopular = collection
                self?.presenter?.updateUI()
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}
