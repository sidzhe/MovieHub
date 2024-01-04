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
    
    func getSearchData() -> [Doc] {
        guard let model = interactor?.searchData?.docs else { return [Doc]() }
        return model
    }
    
    func getAwardsData() -> [DocAwards] {
        guard let model = interactor?.awardsData?.docs else { return [DocAwards]() }
        return model
    }
    
    func getFacts() -> [String] {
        guard let model = interactor?.personDetailData?.docs?.first?.facts else { return [String]() }
        let output = model.compactMap { removingHTMLEscapes(text: $0.value) }
        return output
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
    
    private func removingHTMLEscapes(text: String?) -> String? {
        guard let text = text else { return nil }
        
        do {
            let regex = try NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
            let range = NSRange(location: 0, length: text.utf16.count)
            let htmlFreeString = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
            return htmlFreeString
        } catch {
            print("Ошибка при удалении HTML-тегов: \(error)")
            return nil
        }
    }
    
    //MARK: Route to VC
    func routeToDetail() {
        router?.pushToDetail(from: view)
    }
    
    func routeToPopular() {
        router?.pushToPopularMovie(from: view)
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
