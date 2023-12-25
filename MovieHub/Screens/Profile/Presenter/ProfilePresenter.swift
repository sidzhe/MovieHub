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
    
    
}


//MARK: - Extension ProfileInteractorOutputProtocol
extension ProfilePresenter: ProfileInteractorOutputProtocol {
    
}
