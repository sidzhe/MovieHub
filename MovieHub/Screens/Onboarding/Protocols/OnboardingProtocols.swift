//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol OnboardingViewProtocol: AnyObject {
    var presenter: OnboardingPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol OnboardingPresenterProtocol: AnyObject {
    var view: OnboardingViewProtocol? { get set }
}

/// PRESENTER -> INTERACTOR
protocol OnboardingInteractorInputProtocol: AnyObject {
    var presenter: OnboardingInteractorOutputProtocol? { get set }
}

/// INTERACTOR -> PRESENTER
protocol OnboardingInteractorOutputProtocol: AnyObject {
    
}

/// PRESENTER -> ROUTER
protocol OnboardingRouterProtocol: AnyObject {
    
}
