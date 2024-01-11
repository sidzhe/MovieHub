//
//  WishlistPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class WishlistPresenter: WishlistPresenterProtocol {
    func getWishListData() {
        <#code#>
    }
    
    
    //MARK: Properties
    weak var view: WishlistViewProtocol?
    var interactor: WishlistInteractorInputProtocol?
    var router: WishlistRouterProtocol?
    
    
}


//MARK: - Extension WishlistInteractorOutputProtocol
extension WishlistPresenter: WishlistInteractorOutputProtocol {
    func updateUI() {
        view?.updateUI(model: interactor?.wishListMovieData)
    }
    
    func getData() -> SearchModel {
        
    }
}
