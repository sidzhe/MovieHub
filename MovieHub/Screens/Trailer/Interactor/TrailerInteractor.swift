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
    var detailModel: DetailModel?
    var urlImages: [GaleryDoc]?
    
    //MARK: Init
    init(detailModel: DetailModel?) {
        self.detailModel = detailModel
    }
}
