//
//  WishlistInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class WishlistInteractor: WishlistInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: WishlistInteractorOutputProtocol?
    private var networkService: NetworkServiceProtocol
    private var storageService: StorageServiceProtocol
    private var favoriteMoviesID: [String]?
    var favoriteModel: [Doc]?
    
    //MARK: - Init
    init(networkService: NetworkServiceProtocol, storageService: StorageServiceProtocol) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    //MARK: Get favorites model
    func updateWishModel() {
        self.favoriteMoviesID = storageService.getWishModel()
        guard let ids = favoriteMoviesID, !ids.isEmpty else { return }
        requestWish(ids)
    }
    
    func checkWishElement(id: Int) {
        storageService.checkWish(id: id)
    }
    
    //MARK: - Request wish
    func requestWish(_ ids: [String]) {
        networkService.searchMovieById(identifiers: ids) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            
            switch result {
                
            case .success(let movies):
                self?.favoriteModel = movies.docs
                self?.presenter?.updateUI()
            case .failure(let error):
                self?.presenter?.showError(error: error)
            }
        }
    }
    
}

