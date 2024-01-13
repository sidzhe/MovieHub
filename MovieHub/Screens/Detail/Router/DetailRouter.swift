//
//  DetailRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class DetailRouter: DetailRouterProtocol {
    
    //MARK: Route to trailer
    func pushToTrailer(from view: DetailViewProtocol?, detailModel: DetailModel) {
        guard let view = view as? UIViewController else { return }
        let trailerVC = Builder.createTrailer(detailModel: detailModel)
        view.navigationController?.pushViewController(trailerVC, animated: true)
    }
}
