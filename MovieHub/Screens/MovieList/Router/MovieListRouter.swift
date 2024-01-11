//
//  MovieListRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class MovieListRouter: MovieListRouterProtocol {
    
    //MARK: Route to Detail
    func pushToDetail(from view: MovieListViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail()
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
