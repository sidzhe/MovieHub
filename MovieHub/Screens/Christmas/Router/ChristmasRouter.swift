//
//  ChristmasRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class ChristmasRouter: ChristmasRouterProtocol {
    
    //MARK: Route to Detail
    func pushToDetailMovie(from view: ChristmasViewProtocol?) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createPersonDetail(personId: 51434)
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
