//
//  CityListPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 07.01.2024.
//

import Foundation

final class CityListPresenter: CityListPresenterProtocol {
    
    //MARK: Properties
    weak var view: CityListViewProtocol?
    var interactor: CityListInteractorInputProtocol?
    var router: CityListRouterProtocol?
    
    //MARK: Get data for collectionView
    func getCityList() -> [String] {
        guard let interactor = interactor else { return [String]() }
        return interactor.cityList
    }
    
    func getFilteredCity() -> [String] {
        guard let model = interactor?.filteredCity else { return [String]() }
        return model
    }
    
    //MARK: - Filter city
    func filteredCity(with filter: String?) -> [String] {
        guard let interactor = interactor else { return [String]() }
        guard let filter = filter, !filter.isEmpty else { return interactor.cityList }
        let data = interactor.cityList.filter({ $0.contains(filter) })
        interactor.filteredCity = data
        return data
    }
        
    //MARK: Save selected city
    func saveSelectedCity(name: String) {
        interactor?.saveCurrentCityToCD(city: name)
    }
    
    //MARK: Route to
    func routeToPrevious() {
        router?.pushBack(view: view)
    }
}


//MARK: - Extension CityListInteractorOutputProtocol
extension CityListPresenter: CityListInteractorOutputProtocol {
    
}
