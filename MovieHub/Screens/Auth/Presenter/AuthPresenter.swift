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
    
    func addNewUser(user: AuthModel) {
        interactor?.addNewUser(user: user)
    }
    
    func loginUser(email: String, password: String) {
        guard let model = interactor?.loginUser(email: email, password: password) else { return }
        switch model {
        case .success():
            router?.pushToTabBar(from: view)
        case .failure(let error):
            print(error)
            view?.displayError(error: error.localizedDescription)
        }
    }
    
    func routeToTabBar() {
        router?.pushToTabBar(from: view)
    }
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
