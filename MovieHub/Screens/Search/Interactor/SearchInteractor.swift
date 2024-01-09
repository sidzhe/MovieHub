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
    
    var categories = MovieGenre.allCases.map { $0.rawValue }
    
    var searchPerson: PersonModel?
    var searchMovie: SearchModel?
    var upcomingMovie: UpcomingModel?
    var recentMovie: [Doc] = []
    
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func requestPerson(name: String) {
        networkService.searchPerson(name) { [weak self] (result: (Result<PersonModel, RequestError>)) in
                                                                  
            guard let self else { return }
            switch result {
                
            case .success(let person):
                self.searchPerson = person
            case .failure(let error):
                self.presenter?.getError(error: error)
            }
        }
    }
    
    func requestSearch(_ title: String) {
        networkService.searchTitle(title) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
                
            case .success(let search):
                self.searchMovie = search
            case .failure(let error):
                self.presenter?.getError(error: error)
            }
        }
    }
    
    func requestUpcomingMovie(category: MovieGenre) {
        networkService.getmovieUpcomingGenres(genre: category) { [weak self] (result: (Result<UpcomingModel, RequestError>)) in
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
