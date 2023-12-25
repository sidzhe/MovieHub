//
//  PopularPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class PopularPresenter: PopularPresenterProtocol {
    
    //MARK: Properties
    weak var view: PopularViewProtocol?
    var interactor: PopularInteractorInputProtocol?
    var router: PopularRouterProtocol?
    
    
}


//MARK: - Extension PopularInteractorOutputProtocol
extension PopularPresenter: PopularInteractorOutputProtocol {
    
}
