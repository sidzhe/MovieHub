//
//  WishListService.swift
//  MovieHub
//
//  Created by Dmitry on 08.01.2024.
//

import Foundation

//MARK: - Wishlist protocol

protocol WishListServiceProtocol: AnyObject {
    
    func addToFavorites(movie: DetailModel)
    func removefromFavorites(movie: DetailModel)
    func getAllFavoriteMovie() -> [DetailModel]
}

final class WishListService: WishListServiceProtocol {
    func addToFavorites(movie: DetailModel) {
        //add to favorites
    }
    
    func removefromFavorites(movie: DetailModel) {
        //removefromFavorites
    }
    
    func getAllFavoriteMovie() -> [DetailModel] {
        [DetailModel]()
    }
    
    
}
