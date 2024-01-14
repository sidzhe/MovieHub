//
//  SearchResultInteractor.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 09.01.2024.
//
import Foundation

final class SearchResultInteractor: SearchResultInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: SearchResultInteractorOutputProtocol?
    var networkService: NetworkServiceProtool
    
    var searchPerson: PersonModel?
    var searchMovie: SearchModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtool) {
        self.networkService = networkService
    }
    
    //MARK: Methods
    func requestPerson(name: String) {
        networkService.searchPerson(name) { [weak self] (result: (Result<PersonModel, RequestError>)) in
            
            guard let self else { return }
            switch result {
                
            case .success(let person):
                self.searchPerson = person
                self.presenter?.updateUI()
            case .failure(let error):
                self.presenter?.getError(error: error)
            }
        }
    }
    
    func requestSearch(_ title: String) {
        networkService.searchMovieByTitle(title) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            guard let self = self else { return }
            switch result {
            case .success(let search):
                self.searchMovie = search
                self.presenter?.updateUI()
            case .failure(let error):
                self.presenter?.getError(error: error)
            }
        }
    }
}

