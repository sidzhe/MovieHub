//
//  PersonDetailPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import Foundation

final class PersonDetailPresenter: PersonDetailPresenterProtocol {
    
    //MARK: Properties
    weak var view: PersonDetailViewProtocol?
    var interactor: PersonDetailInteractorInputProtocol?
    var router: PersonDetailRouterProtocol?
    
    
}


//MARK: - Extension PersonDetailInteractorOutputProtocol
extension PersonDetailPresenter: PersonDetailInteractorOutputProtocol {
    
}
