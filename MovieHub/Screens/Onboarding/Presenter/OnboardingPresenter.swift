//
//  OnboardingPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import Foundation

final class OnboardingPresenter: OnboardingPresenterProtocol {
    
    //MARK: Properties
    weak var view: OnboardingViewProtocol?
    var interactor: OnboardingInteractorInputProtocol?
    var router: OnboardingRouterProtocol?
    
    
    func safeUserDefaults() {
        let state = true
        UserDefaults.standard.set(state, forKey: "state")
    }
    
}


//MARK: - Extension OnboardingInteractorOutputProtocol
extension OnboardingPresenter: OnboardingInteractorOutputProtocol {
    
}
