//
//  WishlistPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class WishlistPresenter: WishlistPresenterProtocol {
    
    
    
    //MARK: Properties
    weak var view: WishlistViewProtocol?
    var interactor: WishlistInteractorInputProtocol?
    var router: WishlistRouterProtocol?
    
    private var wishListMovieData: [SearchModel]? {
        didSet {
            guard let wishListMovieData else {return}
            let convertedtoDocData = wishListMovieData.compactMap {$0.docs.first}
            view?.updateUI(model: convertedtoDocData)
        }
    }
    
    //MARK: - WishlistPresenterProtocol
    func getWishListData() {
        interactor?.startFetchWishListData()
    }
    
}


//MARK: - Extension WishlistInteractorOutputProtocol
extension WishlistPresenter: WishlistInteractorOutputProtocol {
    func updateUI(model: [SearchModel]?) {
        self.wishListMovieData = model
    }
    
    func showError(error: Error) {
        //some code here
    }
}
