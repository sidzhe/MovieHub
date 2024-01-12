//
//  WishlistRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class WishlistRouter: WishlistRouterProtocol {
    
    //MARK: Push DetailVC
    func pushToDetail(from: WishlistViewProtocol?, id: Int) {
        guard let view = from as? UIViewController else { return }
        let detailVC = Builder.createDetail(detailID: "")
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
}
