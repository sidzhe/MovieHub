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
        guard let model = interactor?.favoriteModel else { return [Doc]() }
        return model
    }
    
    //MARK: Udate and request model
    func updateModel() {
        interactor?.updateWishModel()
    }
    
    //MARK: Remove item from collection model
    func removeItem(at indexPath: IndexPath) {
        var model = getWishListData()
        guard model.count > indexPath.row else { return }
        let removedItemId = model[indexPath.row].id ?? 0
        interactor?.checkWishElement(id: removedItemId)
        model.remove(at: indexPath.row)
        interactor?.favoriteModel = model
        view?.removeItemFromCollection(at: indexPath)
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
