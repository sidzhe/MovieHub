//
//  PersonDetailProtocols.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol PersonDetailViewProtocol: AnyObject {
    var presenter: PersonDetailPresenterProtocol? { get set }
    func updateUI()
    func displayRequestError(_ error: RequestError)
}

/// VIEW -> PRESENTER
protocol PersonDetailPresenterProtocol: AnyObject {
    var view: PersonDetailViewProtocol? { get set }
    func getPersonDetailData() -> PersonDetalModel?
    func getSearchData() -> [Doc]?
    func convertModel(model: [BirthPlace]?) -> String
    func dateFormatter(_ convertDate: String?) -> String
    func formatAgeString(age: Int?) -> String
    func routeToDetail()
}

/// PRESENTER -> INTERACTOR
protocol PersonDetailInteractorInputProtocol: AnyObject {
    var presenter: PersonDetailInteractorOutputProtocol? { get set }
    var searchData: SearchModel? { get }
    var personDetailData: PersonDetalModel? { get }
}

/// INTERACTOR -> PRESENTER
protocol PersonDetailInteractorOutputProtocol: AnyObject {
    func updateUI()
    func getRequestError(_ error: RequestError)
}

/// PRESENTER -> ROUTER
protocol PersonDetailRouterProtocol: AnyObject {
    func pushToDetail(from view: PersonDetailViewProtocol?)
}
