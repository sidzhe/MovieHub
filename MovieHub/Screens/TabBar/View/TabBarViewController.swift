//
//  TabBarViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class TabBarViewController: UITabBarController, UIGestureRecognizerDelegate {
    
    //MARK: Properties
    var presenter: TabBarPresenterProtocol?
    
    //MARK: UI Elements
    private let tabBarHomeView = TabBarView(icon: UIImage(systemName: "house")!, title: "Home", tag: 0)
    private let tabBarSearchView = TabBarView(icon: UIImage(systemName: "magnifyingglass")!, title: "Search", tag: 1)
    private let tabBarTreeView = TabBarView(icon: UIImage(systemName: "puzzlepiece.extension")!, title: "Tree", tag: 2)
    private let tabBarProfileView = TabBarView(icon: UIImage(systemName: "person.circle.fill")!, title: "Profile", tag: 3)
    
    private lazy var selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = .primarySoft
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 17
        view.backgroundColor = .clear
        return view
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.delegate = self
        stackView.addGestureRecognizer(tapGesture)
        
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
        tabBar.isHidden = true
        
        let customView = UIView()
        view.addSubview(customView)
        customView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(85)
        }
        customView.backgroundColor = .primaryDark
        customView.addSubview(selectedView)
        customView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        stackView.addArrangedSubview(tabBarHomeView)
        stackView.addArrangedSubview(tabBarSearchView)
        stackView.addArrangedSubview(tabBarTreeView)
        stackView.addArrangedSubview(tabBarProfileView)
        
        selectedView.snp.makeConstraints { make in
            make.center.equalTo(tabBarHomeView.snp.center)
            make.height.equalTo(40)
            make.width.equalTo(90)
        }
    }
    
    
    //MARK: - CreateTabBar
    private func createTabBar() {
        let homeVC = Builder.createMain()
        let searchVC = Builder.createSearch()
        let christmasVC = Builder.createChristmas()
        let profileVC = Builder.createProfile()
        
        viewControllers = [
            //            generateVC(homeVC, "Home", UIImage(systemName: "house")),
            generateVC(searchVC, "Search", UIImage(systemName: "magnifyingglass")),
            generateVC(christmasVC, "Tree", UIImage(systemName: "puzzlepiece.extension")),
            generateVC(profileVC, "Account", UIImage(systemName: "person.circle.fill"))
        ]
    }
    
    //MARK: Tap Gesture
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        
        let tappedPoint = sender.location(in: stackView)
        
        if let tappedSubview = stackView.hitTest(tappedPoint, with: nil) as? TabBarView {
            selectedIndex = tappedSubview.tag
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let self = self else { return }
                let centerX = tappedSubview.frame.origin.x + tappedSubview.frame.width + 5
                self.selectedView.center = CGPoint(x: centerX, y: self.selectedView.center.y)
            }
        }
    }
}


//MARK: - Extension TabBarViewProtocol
extension TabBarViewController: TabBarViewProtocol {
    
}
