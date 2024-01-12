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
    private var wishListService: WishListServiceProtocol
    private var favoriteMoviesID: [Int]? {
        didSet {
            guard let favoriteMoviesID, favoriteMoviesID.count > 0 else {return}
            wishListMovieData = [SearchModel]()
            for id in favoriteMoviesID {
                networkService.searchMovieById(identifier: String(id)) { result in
                    switch result {
                    case .failure(_) :
                        self.wishListMovieData.append(self.createEmptySearchModel(text: "Фильм больше не доступен"))
                    case .success(let searchModel): self.wishListMovieData.append(searchModel)
                    }
                }
            }
        }
    }
    private var wishListMovieData = [SearchModel]() {
        didSet {
            guard wishListMovieData.count == favoriteMoviesID?.count else {return}
            presenter?.updateUI(model: wishListMovieData)
        }
    }
    
    //MARK: - Init
    init(networkService: NetworkServiceProtool, wishListService: WishListServiceProtocol) {
        self.networkService = networkService
        self.wishListService = wishListService
    }

    //MARK: - Methods
    private func createEmptySearchModel(text: String) -> SearchModel {
        let doc = Doc(id: nil, name: text, alternativeName: nil, enName: nil, type: nil, year: nil, docDescription: nil, shortDescription: nil, movieLength: nil, isSeries: nil, ticketsOnSale: nil, totalSeriesLength: nil, seriesLength: nil, ratingMPAA: nil, ageRating: nil, top10: nil, top250: nil, typeNumber: nil, status: nil, names: nil, externalId: nil, poster: nil, backdrop: nil, rating: nil, votes: nil, genres: nil, countries: nil, releaseYears: nil)
        return SearchModel(docs: [doc], total: 0, limit: 0, page: 0, pages: 0)
    }
    //MARK: - WishlistInteractorInputProtocol
    func startFetchWishListData() {
        favoriteMoviesID = wishListService.getAllFavoriteMovie()
    }
}
    
