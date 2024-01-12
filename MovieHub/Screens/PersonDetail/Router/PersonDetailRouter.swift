//
//  PersonDetailRouter.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import UIKit

final class PersonDetailRouter: PersonDetailRouterProtocol {
    
    //MARK: Route to Detail
    func pushToDetail(from view: PersonDetailViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail()
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: Route to PupalarMovie
    func pushToPopularMovie(from view: PersonDetailViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let popularMovieVC = Builder.createPopular()
        view.navigationController?.pushViewController(popularMovieVC, animated: true)
    }
}
