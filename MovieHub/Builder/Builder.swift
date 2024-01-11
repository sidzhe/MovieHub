//
//  Builder.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit

final class Builder {
    
    private init() {}
    
    /// TabBarVC
    static func createTabBar() -> UIViewController {
        let view = TabBarViewController()
        let presenter = TabBarPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    /// OnboardingVC
    static func createOnboarding() -> UIViewController {
        let view = OnboardingViewController()
        let presenter = OnboardingPresenter()
        let interactor = OnboardingInteractor()
        let router = OnboardingRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// MainVC
    static func createMain() -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter()
        let networkService = NetworkService()
        let interactor = MainInteractor(networkService: networkService)
        let router = MainRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// MovieListVC
    static func createMovieList() -> UIViewController {
        let view = MovieListViewController()
        let presenter = MovieListPresenter()
        let interactor = MovieListInteractor()
        let router = MovieListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// PopularVC
    static func createPopular() -> UIViewController {
        let view = PopularViewController()
        let presenter = PopularPresenter()
        let interactor = PopularInteractor()
        let router = PopularRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// DetailVC
    static func createDetail() -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// WishlistVC
    static func createWishlist() -> UIViewController {
        let view = WishlistViewController()
        let presenter = WishlistPresenter()
        let interactor = WishlistInteractor()
        let router = WishlistRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// SearchVC
    static func createSearch() -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter()
        let networkService = NetworkService()
        let interactor = SearchInteractor(networkService: networkService)
        let router = SearchRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// SearchResultVC
    static func createSearchResult() -> UIViewController {
        let view = SearchResultsViewController()
        let presenter = SearchResultPresenter()
        let networkService = NetworkService()
        let interactor = SearchResultInteractor(networkService: networkService)
        let router = SearchResultRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// ProfileVC
    static func createProfile() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// ChristmasVC
    static func createChristmas() -> UIViewController {
        let view = ChristmasViewController()
        let presenter = ChristmasPresenter()
        let networkService = NetworkService()
        let interactor = ChristmasInteractor(networkService: networkService)
        let router = ChristmasRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// PersonDetailVC
    static func createPersonDetail(personId: Int) -> UIViewController {
        let view = PersonDetailViewController()
        let presenter = PersonDetailPresenter()
        let networkService = NetworkService()
        let interactor = PersonDetailInteractor(networkService: networkService, personId: personId)
        let router = PersonDetailRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
}
