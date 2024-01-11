//
//  WishlistInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class WishlistInteractor: WishlistInteractorInputProtocol {
    func startFetchWishListData() {
        favoriteMoviesID = wishListService.getAllFavoriteMovie()    
    }
    

    //MARK: - Properties
    weak var presenter: WishlistInteractorOutputProtocol?
    var networkService: NetworkServiceProtool
    var wishListService: WishListServiceProtocol
    private var favoriteMoviesID: [Int]? {
        didSet {
            guard let favoriteMoviesID, favoriteMoviesID.count > 0 else {return}
            for id in favoriteMoviesID {
                networkService.searchMovieById(identifier: String(id)) { result in
                    switch result {
                    case .failure(let error) : 
                        self.presenter?.showError(error: error)
                        self.wishListMovieData?.append(self.createEmptySearchModel())
                    case .success(let searchModel): self.wishListMovieData?.append(searchModel)
                    }
                }
            }
        }
    }
    var wishListMovieData: [SearchModel]? {
        didSet {
            guard let wishListMovieData else {return}
            
        }
    }
    
    //MARK: - Init
    init(networkService: NetworkServiceProtool, wishListService: WishListServiceProtocol) {
        self.networkService = networkService
        self.wishListService = wishListService
    }

    //MARK: - Methods
    private func createEmptySearchModel() -> SearchModel {
        let doc = Doc(id: nil, name: nil, alternativeName: nil, enName: nil, type: nil, year: nil, docDescription: nil, shortDescription: nil, movieLength: nil, isSeries: nil, ticketsOnSale: nil, totalSeriesLength: nil, seriesLength: nil, ratingMPAA: nil, ageRating: nil, top10: nil, top250: nil, typeNumber: nil, status: nil, names: nil, externalId: nil, poster: nil, backdrop: nil, rating: nil, votes: nil, genres: nil, countries: nil, releaseYears: nil)
        return SearchModel(docs: [doc], total: 0, limit: 0, page: 0, pages: 0)
    }
}

extension WishlistInteractor: WishlistInteractorOutputProtocol {
    func updateUI(model: [SearchModel]?) {
        presenter?.updateUI(model: model)
    }
    
    func showError(error: Error) {
        presenter?.showError(error: error)
    }
    
}
