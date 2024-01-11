//
//  WishListService.swift
//  MovieHub
//
//  Created by Dmitry on 08.01.2024.
//

import Foundation

//MARK: - Wishlist protocol

protocol WishListServiceProtocol: AnyObject {
    
    func addToFavorites(movieID: Int)
    func removefromFavorites(movieID: Int)
    func getAllFavoriteMovie() -> [Int]
}

final class WishListService: WishListServiceProtocol {
    func addToFavorites(movieID: Int) {
        //add to favorites
    }
    
    func removefromFavorites(movieID: Int) {
        //removefromFavorites
    }
    
    func getAllFavoriteMovie() -> [Int] {
        [3,4,5]
    }
    
    
}
