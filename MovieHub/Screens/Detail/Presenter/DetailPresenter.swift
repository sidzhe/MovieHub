//
//  DetailPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class DetailPresenter: DetailPresenterProtocol {
    
    //MARK: Properties
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var router: DetailRouterProtocol?
    
    
}


//MARK: - Extension DetailInteractorOutputProtocol
extension DetailPresenter: DetailInteractorOutputProtocol {
    
}
