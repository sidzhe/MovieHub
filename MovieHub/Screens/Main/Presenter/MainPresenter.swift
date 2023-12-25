//
//  MainPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class MainPresenter: MainPresenterProtocol {
    
    //MARK: Properties
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    
}


//MARK: - Extension MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    
}
