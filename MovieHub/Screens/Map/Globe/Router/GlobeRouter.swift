//
//  GlobeRouter.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import UIKit

final class GlobeRouter: GlobeRouterProtocol {
    
    //MARK: Route to map
    func pushToMap(from view: GlobeViewProtocol?, cityName: String, userLocation: Location, selectedCityLocation: Location) {
        guard let view = view as? UIViewController else { return }
        let mapVC = Builder.createMap(currentCity: cityName, userLocation: userLocation, selectedCityLocation: selectedCityLocation)
        view.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    //MARK: Route to СityList
    func pushToCityList(from view: GlobeViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let cityListVC = Builder.createCityList()
        view.navigationController?.pushViewController(cityListVC, animated: true)
    }
    
    //MARK: Route to detailCinema
    func pushToCinemaList(from view: GlobeViewProtocol?, globeCinema: GlobeCinema) {
        guard let view = view as? UIViewController else { return }
        let mapVC = Builder.createDetailCinema(globeCinema: globeCinema)
        view.navigationController?.pushViewController(mapVC, animated: true)
    }
}
