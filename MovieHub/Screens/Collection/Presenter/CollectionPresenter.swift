//
//  CollectionPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import Foundation

final class CollectionPresenter: CollectionPresenterProtocol {
    
    //MARK: Properties
    weak var view: CollectionViewProtocol?
    var interactor: CollectionInteractorInputProtocol?
    var router: CollectionRouterProtocol?
    
    //MARK: Get model
    func getCollectionModel() -> [Doc] {
        guard let model = interactor?.collectionData?.docs else { return [Doc]() }
        return model
    }
    
    //MARK: Route to
    func routeToDetail(index: Int) {
        guard let id = getCollectionModel()[index].id else { return }
        router?.pushToDetail(from: view, detailId: id)
    }
}


//MARK: - Extension CollectionInteractorOutputProtocol
extension CollectionPresenter: CollectionInteractorOutputProtocol {
    
    func updateUI() {
        view?.updateUI()
    }
    
    func getError(_ error: String) {
        view?.displayError(error)
    }
}
