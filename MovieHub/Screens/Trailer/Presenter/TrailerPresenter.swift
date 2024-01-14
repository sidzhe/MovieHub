//
//  TrailerPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 13.01.2024.
//

import Foundation

final class TrailerPresenter: TrailerPresenterProtocol {
    
    //MARK: Properties
    weak var view: TrailerViewProtocol?
    var interactor: TrailerInteractorInputProtocol?
    var router: TrailerRouterProtocol?
    
    //MARK: Get person
    func getPerson() -> [Person]? {
        guard let model = interactor?.detailModel?.persons else { return nil }
        return model
    }
    
    //MARK: Get images
    func getImages() -> [GaleryDoc] {
        guard let model = interactor?.urlImages else { return [GaleryDoc]() }
        return model
    }
    
    //MARK: Make trailer id
    func makeTrailerId() -> String {
        guard let model = interactor?.detailModel?.videos?.trailers?.first?.url,
              let output = model.components(separatedBy: "/").last else { return Constant.none }
        return output
    }
}


//MARK: - Extension TrailerInteractorOutputProtocolw
extension TrailerPresenter: TrailerInteractorOutputProtocol {
    func getError(_ error: String) {
        view?.displayError(error)
    }
    
    func updateUI() {
        view?.updateUI()
    }
}
