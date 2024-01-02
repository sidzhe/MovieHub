//
//  PersonDetailPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import Foundation

final class PersonDetailPresenter: PersonDetailPresenterProtocol {

    //MARK: Properties
    weak var view: PersonDetailViewProtocol?
    var interactor: PersonDetailInteractorInputProtocol?
    var router: PersonDetailRouterProtocol?
    
    //MARK: Get data
    func getPersonDetailData() -> PersonDetalModel? {
        guard let model = interactor?.personDetailData else { return nil }
        return model
    }
    
    func getSearchData() -> [Doc]? {
        guard let model = interactor?.searchData?.docs else { return nil }
        return model
    }
}


//MARK: - Extension PersonDetailInteractorOutputProtocol
extension PersonDetailPresenter: PersonDetailInteractorOutputProtocol {
    func updateUI() {
        view?.updateUI()
    }
    
    func getRequestError(_ error: RequestError) {
        view?.displayRequestError(error)
    }
}
