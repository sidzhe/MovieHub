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
    
    func getAwardsData() -> [DocAwards]? {
        guard let model = interactor?.awardsData?.docs.filter({ $0.winning == true }) else { return nil }
        return model
    }
    
    //MARK: Conver methods
    func convertModel(model: [BirthPlace]?) -> String {
        model?.compactMap { "• " + ($0.value ?? "") }.joined(separator: "\n") ?? ""
    }
    
    func dateFormatter(_ convertDate: String?) -> String {
        guard let convertDate = convertDate else { return "" }
        var resultString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        if let date = dateFormatter.date(from: convertDate) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "d MMMM yyyy"
            outputDateFormatter.locale = Locale(identifier: "ru_RU")
            resultString = " • " + outputDateFormatter.string(from: date)
        }
        
        return resultString
    }
    
    func formatAgeString(age: Int?) -> String {
        guard let age = age else { return "" }
        if age % 10 == 1 && age % 100 != 11 {
            return "\(age) год"
        } else if age % 10 >= 2 && age % 10 <= 4 && (age % 100 < 10 || age % 100 >= 20) {
            return "\(age) года"
        } else {
            return "\(age) лет"
        }
    }
    
    //MARK: Route to Detail
    func routeToDetail() {
        router?.pushToDetail(from: view)
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
