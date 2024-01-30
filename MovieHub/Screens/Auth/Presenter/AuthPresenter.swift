//
//  AuthPresenter.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.01.2024.
//

import Foundation

final class AuthPresenter: AuthPresenterProtocol {
    
    //MARK: Properties
    weak var view: AuthViewProtocol?
    var interactor: AuthInteractorInputProtocol?
    var router: AuthRouterProtocol?
    
}

//MARK: - Extension SearchInteractorOutputProtocol
extension AuthPresenter: AuthInteractorOutputProtocol {
    func updateUI() {
        //
    }
    
    func getError(error: RequestError) {
        //
    }
}
