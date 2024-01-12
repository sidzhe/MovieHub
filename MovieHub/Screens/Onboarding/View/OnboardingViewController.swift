//
//  OnboardingViewController.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIPageViewController {
    //UIViewController, UIPageViewControllerDelegate {
    
    //MARK: Properties
    var presenter: OnboardingPresenterProtocol?
    
    var myControllers = [UIViewController]()
    let pageControl = UIPageControl() // external - not part of underlying pages
    let initialPage = 0
    
    //MARK: UI Elements

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let page1 = TextViewController(imageName: "Onboarding1", titleText: "Onboarding1", buttonImage: "NextButton1")
        let page2 = TextViewController(imageName: "Onboarding2", titleText: "Onboarding2", buttonImage: "NextButton2")
        let page3 = TextViewController(imageName: "Onboarding3", titleText: "Onboarding3", buttonImage: "NextButton3")
        
        pageControl.numberOfPages = myControllers.count
        
        myControllers.append(page1)
        myControllers.append(page2)
        myControllers.append(page3)
        
        //UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        setViewControllers([myControllers[initialPage]], direction: .forward, animated: true, completion: nil)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = myControllers.count
        pageControl.currentPage = initialPage
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(45)
            make.bottom.equalToSuperview().inset(80)
        }
                
        
//                pageViewController = UIPageViewController(transitionStyle: .scroll,
//                                                          navigationOrientation: .horizontal,
//                                                          options: nil)
        //
        //        pageViewController?.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        //
        //        pageViewController.dataSource = self
        //        pageViewController.delegate = self
        //
        //        self.addChild(pageViewController)
        //        self.view.addSubview(pageViewController.view)
        //        pageViewController.view.frame = self.view.frame
        //        pageViewController.didMove(toParent: self)
    }
    
    //MARK: - viewDidLayoutSubviews
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        setupUI()
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
//            self.presentPageVC()
//        })
//    }
    
//    private func presentPageVC() {
//        guard let first = myControllers.first else {
//            return
//        }
//        let vc = UIPageViewController(
//            transitionStyle: .scroll,
//            navigationOrientation: .horizontal,
//            options: nil)
//        
//        vc.delegate = self
//        vc.dataSource = self
        
//        vc.setViewControllers([first],
//                              direction: .forward,
//                              animated: true,
//                              completion: nil)
//        
//        present(vc, animated: true)
//    }
//    
//        private func setupUI() {
//          //  view.backgroundColor = .black
//    
//            pageControl.snp.makeConstraints { make in
//                make.left.equalToSuperview().inset(45)
//                make.bottom.equalToSuperview().inset(60)
//            }
//     }
    
//        @objc private func startButtonPressed() {
//            let homeVC = Builder.createTabBar()
//            homeVC.modalPresentationStyle = .fullScreen
//            homeVC.modalTransitionStyle = .crossDissolve
//            present(homeVC, animated: true)
//        }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter!.safeUserDefaults()
        
    }
}
extension OnboardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController) else {
            return nil
        }
        let reducedIndex = index - 1
        
        guard reducedIndex >= 0 else {
            return nil
        }
        guard myControllers.count > reducedIndex else {
            return nil
        }
        return myControllers[reducedIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = myControllers.firstIndex(of: viewController) else {
            return nil
        }
        let increasedIndex = index + 1
        
        guard increasedIndex >= 0 else {
            return nil
        }
        guard myControllers.count > increasedIndex else {
            return nil
        }
        return myControllers[increasedIndex]
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = myControllers.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}

extension OnboardingViewController {
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([myControllers[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

extension UIPageViewController {
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
}

//MARK: - Extension OnboardingViewProtocol
extension OnboardingViewController: OnboardingViewProtocol {
    
}
