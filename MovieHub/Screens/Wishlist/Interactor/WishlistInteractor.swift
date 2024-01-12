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
    private var networkService: NetworkServiceProtool
    private var storageService: StorageServiceProtool
    private var favoriteMoviesID: [String]?
    var favoriteModel: SearchModel?
    
    //MARK: - Init
    init(networkService: NetworkServiceProtool, storageService: StorageServiceProtool) {
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
                self?.favoriteModel = movies
                self?.presenter?.updateUI()
            case .failure(let eror):
                self?.presenter?.showError(error: eror)
            }
        }
    }
}

