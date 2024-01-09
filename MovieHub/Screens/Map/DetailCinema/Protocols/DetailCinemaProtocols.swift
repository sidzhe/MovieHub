//
//  DetailCinemaProtocols.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation

/// PRESENTER -> VIEW
protocol DetailCinemaViewProtocol: AnyObject {
    var presenter: DetailCinemaPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol DetailCinemaPresenterProtocol: AnyObject {
    var view: DetailCinemaViewProtocol? { get set }
    var cinemaModel: GlobeCinema { get }
    func getCinemaDescription() -> String
}
