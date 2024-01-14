//
//  DetailPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class DetailPresenter: DetailPresenterProtocol {

    //MARK: Properties
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var router: DetailRouterProtocol?
    
    //MARK: Get detail data
    func getDetailData() -> DetailModel? {
        guard let model = interactor?.detailData else { return nil }
        return model
    }
    
    func addRecentMovie() {
        guard let id = getDetailData()?.id else { return }
        interactor?.addRecentMovie(id: id)
    }
    
    //MARK: Check favorites
    func checkFavorites() {
        guard let id = getDetailData()?.id else { return }
        interactor?.checkFavorites(id: id)
    }
    
    //MARK: - Get favorites button state
    func getFavoritesButtonState() -> Bool {
        guard let state = interactor?.getFavoritesButtonState() else { return false }
        return state
    }
    
    //MARK: Route to trailer
    func routeToTrailer() {
        guard let detailModel = interactor?.detailData else { return }
        router?.pushToTrailer(from: view, detailModel: detailModel)
    }
}


//MARK: - Extension DetailInteractorOutputProtocol
extension DetailPresenter: DetailInteractorOutputProtocol {
    
    func updateUI() {
        view?.updateUI()
    }
    
    func getRequestError(_ error: RequestError) {
        view?.displayRequestError(error)
    }
}
