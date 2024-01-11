//
//  CityListRouter.swift
//  MovieHub
//
//  Created by sidzhe on 07.01.2024.
//

import UIKit

final class CityListRouter: CityListRouterProtocol {
    
    //MARK: Push back to GlobeVC
    func pushBack(view: CityListViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
    }
}
