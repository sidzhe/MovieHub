//
//  Router.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit

final class CollectionRouter: CollectionRouterProtocol {
   
    //MARK: Route to Detail
    func pushToDetail(from view: CollectionViewProtocol?, detailId: Int) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail(detailID: detailId.description)
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
