//
//  TabBarViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    //MARK: Properties
    var presenter: TabBarPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        createTabBar()
        
    }
    
    //MARK: - GenerateVC
    private func generateVC(_ viewController: UIViewController, _ title: String?, _ image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let vc = UINavigationController(rootViewController: viewController)
        return vc
    }
    
    
    //MARK: - SetupTabBar
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.selectionIndicatorTintColor = .purple
        appearance.stackedLayoutAppearance.normal.iconColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = appearance.selectionIndicatorTintColor
    }
    
    
    //MARK: - CreateTabBar
    private func createTabBar() {
        let homeVC = Builder.createMain()
        let searchVC = Builder.createSearch()
        let christmasVC = Builder.createChristmas()
        let profileVC = Builder.createProfile()
        
        viewControllers = [
            generateVC(homeVC, "Home", UIImage(systemName: "house")),
            generateVC(searchVC, "Search", UIImage(systemName: "magnifyingglass")),
            generateVC(christmasVC, "Tree", UIImage(systemName: "puzzlepiece.extension")),
            generateVC(profileVC, "Account", UIImage(systemName: "person.circle.fill"))
        ]
    }
}


//MARK: - Extension TabBarViewProtocol
extension TabBarViewController: TabBarViewProtocol {
    
}
