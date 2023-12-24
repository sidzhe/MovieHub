//
//  Builder.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit

final class Builder {
    
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
        return UINavigationController(rootViewController: view)
    }
}
