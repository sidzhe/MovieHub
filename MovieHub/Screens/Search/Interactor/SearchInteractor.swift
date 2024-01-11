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
    var networkService: NetworkServiceProtool
    
    var categories = MovieGenre.allCases.map { $0.rawValue }
    
    var upcomingMovie: UpcomingModel?
    var recentMovie: [Doc] = []
    
    
    //MARK: Init
    init(networkService: NetworkServiceProtool) {
        self.networkService = networkService
    }
    
    //MARK: Request
    func requestUpcomingMovie(category: MovieGenre) {
        networkService.getMovieUpcomingByGenres(genre: category) { [weak self] (result: (Result<UpcomingModel, RequestError>)) in
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
}
