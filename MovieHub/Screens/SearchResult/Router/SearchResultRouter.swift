//
//  SearchResultRouter.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 09.01.2024.
//

import UIKit

final class SearchResultRouter: SearchResultRouterProtocol {
    func pushToDetail(from view: SearchResultViewProtocol?, movieId: Int) {
        guard let view = view as? SearchResultsViewController else { return }
        guard let parentNC = view.parentNavigationController else { return }
        let detailVC = Builder.createDetail()
        parentNC.pushViewController(detailVC, animated: true)
    }
    
    func pushToPersonDetail(from view: SearchResultViewProtocol?, personId: Int) {
        guard let view = view as? SearchResultsViewController else { return }
        guard let parentNC = view.parentNavigationController else { return }
        let personDetailVC = Builder.createPersonDetail(personId: personId)
        parentNC.pushViewController(personDetailVC, animated: true)
    }
    
    
}
