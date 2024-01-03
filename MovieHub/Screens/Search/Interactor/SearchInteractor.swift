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
    var categoriesData = MovieGenre.allCases.map { CategoryModel(category: $0.rawValue) }
    
    var searchMovie: SearchModel?
    var upcomingMovie: [Doc] = []
    var recentMovie: [Doc] = []

    
    //MARK: Init
    init(networkService: NetworkServiceProtool) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func selectedCategory(_ index: Int) {
        categoriesData.enumerated().forEach { categoriesData[$0.offset].isSelected = false }
        categoriesData[index].isSelected = !categoriesData[index].isSelected
        presenter?.updateUI()
    }
    
    
    func requestSearch(_ title: String) {
        networkService.searchTitle(title) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
                
            case .success(let search):
                self.searchMovie = search
                self.presenter?.updateUI()
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
    
    func requestUpcomingMovie(category: MovieGenre) {
        networkService.getmovieUpcomingGenres(genre: category) { [weak self] (result: (Result<[Doc], RequestError>)) in
            guard let self else { return }
            switch result {
                
            case .success(let upcomingMovie):
                self.upcomingMovie = upcomingMovie
                self.presenter?.updateUI()
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}

