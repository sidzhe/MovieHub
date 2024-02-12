//
//  OnboardingRouter.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit

final class OnboardingRouter: OnboardingRouterProtocol {
    func pushToHome(from view: OnboardingViewProtocol?) {
        guard let view = view as? UIViewController else { return }

        let homeVC = Builder.createAuth()
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        view.present(homeVC, animated: true)
    }
}
