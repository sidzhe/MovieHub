//
//  AuthRouter.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.01.2024.
//

import UIKit

final class AuthRouter: AuthRouterProtocol {
    func pushToTabBar(from view: AuthViewProtocol?) {
        guard let view = view as? UIViewController else { return }

        let homeVC = Builder.createTabBar()
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        view.present(homeVC, animated: true)
    }
}
