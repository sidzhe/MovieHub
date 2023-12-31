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
    var searchMovie: SearchModel?
    var searchCategoriesData = MovieGenre.allCases.map { SearchCategoryModel(category: $0.rawValue) }
    var recentMovie: SearchModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtool) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func selectedCategory(_ index: Int) {
        searchCategoriesData.enumerated().forEach { searchCategoriesData[$0.offset].isSelected = false }
        searchCategoriesData[index].isSelected = !searchCategoriesData[index].isSelected
        //  presenter?.updateUI()
    }
    
    
    func requestSearch(_ title: String) {
        networkService.searchTitle(title) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
                
            case .success(let search):
                self.searchMovie = search
                //self.presenter?.updateUI()
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}

