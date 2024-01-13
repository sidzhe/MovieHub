//
//  MovieListRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class MovieListRouter: MovieListRouterProtocol {
    
    //MARK: Route to Detail
    func pushToDetail(from view: MovieListViewProtocol?, detailId: Int) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail(detailID: detailId.description)
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
