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
    private let tapGesture = UITapGestureRecognizer()
    
    //MARK: UI Elements
    private let tabBarHomeView = TabBarView(icon: UIImage(systemName: "play.tv") ?? UIImage(), title: "Home", tag: 0)
    private let tabBarSearchView = TabBarView(icon: UIImage(systemName: "magnifyingglass") ?? UIImage(), title: "Search", tag: 1)
    private let tabBarTreeView = TabBarView(icon: UIImage(systemName: "puzzlepiece.extension.fill") ?? UIImage(), title: "Tree", tag: 2)
    private let tabBarProfileView = TabBarView(icon: UIImage(systemName: "person.fill") ?? UIImage(), title: "Profile", tag: 3)
    
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
        
        setupGesture()
        createTabBar()
        setupTabBar()
        
    }
    
    //MARK: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarHomeView.updateLayout(state: true)
        presenter?.previousViewTag = 0
        
    }
    
    //MARK: - GenerateVC
    private func generateVC(_ viewController: UIViewController, _ title: String?, _ image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        let vc = UINavigationController(rootViewController: viewController)
        return vc
    }
    
    //MARK: - Setup gesture
    private func setupGesture() {
        tapGesture.addTarget(self, action: #selector(handleTap))
        stackView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - SetupTabBar
    private func setupTabBar() {
        tabBar.isHidden = true
        
        let customView = UIView()
        view.addSubview(customView)
        
        stackView.addArrangedSubview(tabBarHomeView)
        stackView.addArrangedSubview(tabBarSearchView)
        stackView.addArrangedSubview(tabBarTreeView)
        stackView.addArrangedSubview(tabBarProfileView)
        
        customView.backgroundColor = .primaryDark
        customView.addSubview(selectedView)
        customView.addSubview(stackView)
        
        customView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(85)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        selectedView.snp.makeConstraints { make in
            make.centerY.equalTo(tabBarHomeView.snp.centerY)
            make.centerX.equalTo(tabBarHomeView.snp.centerX).offset(-4)
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
            generateVC(homeVC, "Home", UIImage(systemName: "house")),
            generateVC(searchVC, "Search", UIImage(systemName: "magnifyingglass")),
            generateVC(christmasVC, "Tree", UIImage(systemName: "puzzlepiece.extension")),
            generateVC(profileVC, "Account", UIImage(systemName: "person.circle.fill"))
        ]
    }
    
    //MARK: Tap Gesture
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        
        let tappedPoint = sender.location(in: stackView)
        
        if let tappedSubview = stackView.hitTest(tappedPoint, with: nil) as? TabBarView {
            guard presenter?.previousViewTag != tappedSubview.tag else { return }
            selectedIndex = tappedSubview.tag
            defer { presenter?.previousViewTag = selectedIndex }
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let self = self else { return }
                let centerX = tappedSubview.frame.origin.x + self.selectedView.frame.width - 35
                self.selectedView.center = CGPoint(x: centerX, y: self.selectedView.center.y)
                tappedSubview.updateLayout(state: true)
                guard let previousTag = presenter?.previousViewTag else { return }
                (stackView.subviews[previousTag] as? TabBarView)?.updateLayout(state: false)
            }
        }
    }
}


//MARK: - Extension TabBarViewProtocol
extension TabBarViewController: TabBarViewProtocol {
    
}
