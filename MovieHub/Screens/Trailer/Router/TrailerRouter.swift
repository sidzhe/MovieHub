//
//  TrailerRouter.swift
//  MovieHub
//
//  Created by sidzhe on 14.01.2024.
//

import UIKit

final class TrailerRouter: TrailerRouterProtocol {
   
    //MARK: Route to Detail
    func pushToDetail(from view: TrailerViewProtocol?, detailId: Int) {
        guard let view = view as? UIViewController else { return }
        let detailPerosnVC = Builder.createPersonDetail(personId: detailId)
        view.navigationController?.pushViewController(detailPerosnVC, animated: true)
    }
}
