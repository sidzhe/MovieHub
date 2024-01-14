//
//  ChristmasRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class ChristmasRouter: ChristmasRouterProtocol {
    
    //MARK: Route to Detail
    func pushToDetail(from view: ChristmasViewProtocol?, id: Int) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail(detailID: id.description)
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
