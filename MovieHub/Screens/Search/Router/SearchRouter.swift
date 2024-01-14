//
//  SearchRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class SearchRouter: SearchRouterProtocol {
    
    func pushToDetail(from view: SearchViewProtocol?, Id: Int) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail(detailID: Id.description)
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
