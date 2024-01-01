//
//  ChristmasInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class ChristmasInteractor: ChristmasInteractorInputProtocol {
    
    //MARK: Properties
    weak var presenter: ChristmasInteractorOutputProtocol?
    private let networkService: NetworkServiceProtool
    private let newYearMovies = ["8124", "56322", "738499", "1828", "42664", "391755"]
    var loadedMovie: DetailModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtool) {
        self.networkService = networkService
    }
    
    //MARK: Search movie
    func getMovieWithId() {
        networkService.searchID(newYearMovies[Int.random(in: 0...5)]) { [weak self] (result: (Result<DetailModel, RequestError>)) in
            switch result {
                
            case .success(let movie):
                self?.loadedMovie = movie
            case .failure(let error):
                self?.presenter?.getRequsetError(error)
            }
        }
    }
}
