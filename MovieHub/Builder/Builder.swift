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
        let view = OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
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
        let networkService = NetworkService()
        let interactor = MovieListInteractor(networkService: networkService)
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
    static func createDetail(detailID: String) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter()
        let networkService = NetworkService()
        let storageService = StorageService()
        let interactor = DetailInteractor(networkService: networkService, storageService: storageService, detailID: detailID)
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
        let networkService = NetworkService()
        let storageService = StorageService()
        let interactor = WishlistInteractor(networkService: networkService, storageService: storageService)
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
        let storageService = StorageService()
        let interactor = SearchInteractor(
            networkService: networkService,
            storageService: storageService
        )
        let router = SearchRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// SearchResultVC
    static func createSearchResult(with navigationController: UINavigationController) -> UIViewController {
        let view = SearchResultsViewController(navigationController: navigationController)
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
    
    /// MapVC
    static func createMap(currentCity: String, userLocation: Location, selectedCityLocation: Location) -> UIViewController {
        let view = MapViewController()
        let presenter = MapPresenter()
        let networkService = NetworkService()
        let interactor = MapInteractor(
            networkService: networkService,
            currentCity: currentCity,
            userLocation: userLocation,
            selectedCityLocation: selectedCityLocation)
        let router = MapRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// GlobeVC
    static func createGlobe(lat: Double, lon: Double, city: String) -> UIViewController {
        let view = GlobeViewController()
        let networkService = NetworkService()
        let storageService = StorageService()
        let presenter = GlobePresenter()
        let interactor = GlobeInteractor(networkService: networkService, storageService: storageService, lat: lat, lon: lon, city: city)
        let router = GlobeRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// DetailCinemaVC
    static func createDetailCinema(globeCinema: GlobeCinema) -> UIViewController {
        let view = DetailCinemaViewController()
        let presenter = DetailCinemaPresenter(cinema: globeCinema)
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
    /// CityListVC
    static func createCityList() -> UIViewController {
        let view = CityListViewController()
        let presenter = CityListPresenter()
        let networkService = NetworkService()
        let storageService = StorageService()
        let interactor = CityListInteractor(networkService: networkService, storageService: storageService)
        let router = CityListRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// CollectionVC
    static func createCollection(slug: String) -> UIViewController {
        let view = CollectionViewController()
        let presenter = CollectionPresenter()
        let networkService = NetworkService()
        let interactor = CollectionInteractor(networkService: networkService, slug: slug)
        let router = CollectionRouter()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        return view
    }
    
    /// TrailerVC
    static func createTrailer(detailModel: DetailModel) -> UIViewController {
        let view = TrailerViewController()
        let presenter = TrailerPresenter()
        let networkService = NetworkService()
        let interactor = TrailerInteractor(networkService: networkService, detailModel: detailModel)
//        let router = Trai()
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
//        presenter.router = router
        interactor.presenter = presenter
        return view
    }
}
