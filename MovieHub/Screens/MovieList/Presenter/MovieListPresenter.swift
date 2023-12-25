//
//  MovieListPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class MovieListPresenter: MovieListPresenterProtocol {
    
    //MARK: Properties
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorInputProtocol?
    var router: MovieListRouterProtocol?
    
    
}


//MARK: - Extension MovieListInteractorOutputProtocol
extension MovieListPresenter: MovieListInteractorOutputProtocol {
    
}
