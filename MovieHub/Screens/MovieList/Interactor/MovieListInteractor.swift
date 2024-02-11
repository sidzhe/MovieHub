//
//  MovieListInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class MovieListInteractor: MovieListInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: MovieListInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol
    var cagegoriesData = MovieGenre.allCases.map { CategoryModel(category: $0.rawValue.localized()) }
    var moviesData: CollectionDetailModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: Select category
    func selectedCategory(_ index: Int) {
        cagegoriesData.enumerated().forEach { cagegoriesData[$0.offset].isSelected = false }
        cagegoriesData[index].isSelected = !cagegoriesData[index].isSelected
        presenter?.updateUI()
    }
    
    //MARK: Movies request
    func requestMovies(genre: MovieGenre) {
        networkService.getRateCollection(genre: genre) { [weak self] (result: (Result<CollectionDetailModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
                
            case .success(let collection):
                self.moviesData = collection
                self.presenter?.updateUI()
            case .failure(let error):
                self.presenter?.getError(error.customMessage)
            }
        }
    }
}
