//
//  ChristmasPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class ChristmasPresenter: ChristmasPresenterProtocol {

    //MARK: Properties
    weak var view: ChristmasViewProtocol?
    var interactor: ChristmasInteractorInputProtocol?
    var router: ChristmasRouterProtocol?
    var backgroundAnimationCount = 0
    var boomAnimationCount = 82
    //MARK:
    func getLoadedMovie() -> DetailModel? {
        guard let model = interactor?.loadedMovie else { return nil }
        return model
    }
    
    func fetchRequest() {
        interactor?.getMovieWithId()
    }
    
    func routeToDetailVC() {
        router?.pushToDetailMovie(from: view)
    }
}


//MARK: - Extension ChristmasInteractorOutputProtocol
extension ChristmasPresenter: ChristmasInteractorOutputProtocol {
    
    func getRequsetError(_ error: RequestError) {
        view?.displayRequestError(error: error)
    }
}
