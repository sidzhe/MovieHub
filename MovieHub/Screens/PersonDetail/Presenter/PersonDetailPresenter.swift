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
        model?.compactMap { Constant.pinSpace + ($0.value ?? Constant.none) }.joined(separator: Constant.separatorN) ?? Constant.none
    }
    
    func dateFormatter(_ convertDate: String?) -> String {
        guard let convertDate = convertDate else { return Constant.none }
        var resultString = Constant.none
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constant.dataFormat
        dateFormatter.timeZone = TimeZone(identifier: Constant.utc)
        
        if let date = dateFormatter.date(from: convertDate) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = Constant.dataFormatOutput
            outputDateFormatter.locale = Locale(identifier: Constant.locale)
            resultString = Constant.spacePinSpace + outputDateFormatter.string(from: date)
        }
        
        return resultString
    }
    
    func formatAgeString(age: Int?) -> String {
        guard let age = age else { return Constant.none }
        if age % 10 == 1 && age % 100 != 11 {
            return "\(age) \(Constant.age)"
        } else if age % 10 >= 2 && age % 10 <= 4 && (age % 100 < 10 || age % 100 >= 20) {
            return "\(age) \(Constant.age2)"
        } else {
            return "\(age) \(Constant.age3)"
        }
    }
    
    func removingHTMLEscapes(text: String?) -> String? {
        guard let text = text else { return nil }
        
        do {
            let regex = try NSRegularExpression(pattern: Constant.htmlSymbols, options: .caseInsensitive)
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
