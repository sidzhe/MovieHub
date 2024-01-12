//
//  ProfilePresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class ProfilePresenter: ProfilePresenterProtocol {
    
    //MARK: Properties
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var router: ProfileRouterProtocol?
    
    func routeToPolicies() {
        guard let view = view else { return }
        router?.pushToPolicies(from: view)
    }
    
    func routeToAboutUs() {
        guard let view = view else { return }
        router?.pushToAboutUs(from: view)
    }
    
    
}


//MARK: - Extension ProfileInteractorOutputProtocol
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
}
