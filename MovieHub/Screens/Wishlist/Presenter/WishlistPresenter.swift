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
    
    //MARK: - WishlistPresenterProtocol
    func getWishListData() -> [Doc] {
        guard let model = interactor?.favoriteModel?.docs else { return [Doc]() }
        return model
    }
    
    //MARK: Udate and request model
    func updateModel() {
        interactor?.updateWishModel()
    }
    
    func checkWishElement(id: Int) {
        interactor?.checkWishElement(id: id)
    }
    
    //MARK: Route to
    func routeToDetail(index: Int) {
        guard let id = getWishListData()[index].id else { return }
        router?.pushToDetail(from: view, id: id)
    }
}


//MARK: - Extension WishlistInteractorOutputProtocol
extension WishlistPresenter: WishlistInteractorOutputProtocol {
    func updateUI() {
        view?.updateUI()
    }
    
    func showError(error: Error) {
        view?.displayRequestError(error: error.localizedDescription)
    }
}
