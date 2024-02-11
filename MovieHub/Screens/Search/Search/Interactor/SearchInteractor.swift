//
//  SearchInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class SearchInteractor: SearchInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: SearchInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol
    let storageService: StorageServiceProtool
    var categories = MovieGenre.allCases.map { $0.rawValue }
    
    var upcomingMovie: SearchModel?
    var recentMovie: SearchModel?
    
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol, storageService: StorageServiceProtool) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    //MARK: Request
    func requestUpcomingMovie(category: MovieGenre) {
        print(category)
        networkService.getMovieUpcomingByGenres(genre: category) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
            case .success(let upcomingMovie):
                
                self.upcomingMovie = upcomingMovie
                self.presenter?.updateUI()
                
            case .failure(let error):
                self.presenter?.getError(error: error)
            }
        }
    }
    
    func requestRecentMovies(with moviesId: [String]) {
        guard !moviesId.isEmpty else { return }
        networkService.searchMovieById(identifiers: moviesId) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            print(moviesId)
            guard let self else { return }
            switch result {
            case .success(let recentMovie):
                self.recentMovie = recentMovie
                self.presenter?.updateUI()
            case .failure(let error):
                self.presenter?.getError(error: error)
            }
        }
    }
    
    //MARK: Storage
    func getRecentMovieIds() -> [String] {
        storageService.loadRecentModel()
    }
}
