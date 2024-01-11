//
//  Router.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit

final class CollectionRouter: CollectionRouterProtocol {
   
    //MARK: Route to Detail
    func pushToDetail(from view: CollectionViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail()
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
