//
//  MainRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class MainRouter: MainRouterProtocol {
    
    //MARK: Route to MovieList
    func pushToMovieList(from view: MainViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let movieListVC = Builder.createMovieList()
        view.navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    //MARK: Route to PupalarMovie
    func pushToPopularMovie(from view: MainViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let popularMovieVC = Builder.createPopular()
        view.navigationController?.pushViewController(popularMovieVC, animated: true)
    }
    
    //MARK: Route to Detail
    func pushToDetail(from view: MainViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let detailVC = Builder.createDetail()
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    //MARK: Route to WishList
    func pushToWishList(from view: MainViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let wishListVC = Builder.createWishlist()
        view.navigationController?.pushViewController(wishListVC, animated: true)
    }
}
