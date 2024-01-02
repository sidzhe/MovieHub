//
//  ChristmasPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class ChristmasPresenter: ChristmasPresenterProtocol {
    
    //MARK: Properties
    weak var view: ChristmasViewProtocol?
    var interactor: ChristmasInteractorInputProtocol?
    var router: ChristmasRouterProtocol?
    
    
}


//MARK: - Extension ChristmasInteractorOutputProtocol
extension ChristmasPresenter: ChristmasInteractorOutputProtocol {
    
}
