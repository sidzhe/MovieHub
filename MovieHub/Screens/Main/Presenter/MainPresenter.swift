//
//  MainPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
    
    //MARK: Properties
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    //MARK: Methods
    func fetch() {
        interactor?.requestCollection()
        interactor?.requestMostRating()
    }
    
    func updateUI() {
        view?.updateUI()
    }
    
    func getColletionModel() -> [DocCollect] {
        guard let model = interactor?.collectionData?.docs else { return [DocCollect]() }
        return model
    }
    
    func getCategories() -> [String] {
        guard let interactor = interactor else { return [String]() }
        return interactor.cagegoriesData
    }
    
    func getMostPopular() -> [Doc] {
        guard let model = interactor?.mostPopular?.docs else { return [Doc]() }
        return model
    }
}


//MARK: - Extension MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {

}
