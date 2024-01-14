//
//  SearchRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class SearchRouter: SearchRouterProtocol {
    
    func pushToDetail(from view: SearchViewProtocol?, movieId: String) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail(detailID: movieId)
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
