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
    var networkService: NetworkServiceProtool
    var cagegoriesData = MovieGenre.allCases.map { CategoryModel(category: $0.rawValue) }
    var moviesData: CollectionDetailModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtool) {
        self.networkService = networkService
        self.requestMovies(genre: .all)
    }
    
    //MARK: Select category
    func selectedCategory(_ index: Int) {
        
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
