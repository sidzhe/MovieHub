//
//  TrailerInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 13.01.2024.
//

import Foundation

final class TrailerInteractor: TrailerInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: TrailerInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol
    var detailModel: DetailModel?
    var urlImages: [GaleryDoc]?
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol, detailModel: DetailModel) {
        self.networkService = networkService
        self.detailModel = detailModel
    }
}
