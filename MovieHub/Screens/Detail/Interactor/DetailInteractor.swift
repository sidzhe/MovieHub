//
//  DetailInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class DetailInteractor: DetailInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: DetailInteractorOutputProtocol?
    var networkManager = NetworkkService()
    
    func fetch(_ id: String) {
        networkManager.searchID(id) {(result: Result<DetailModel, RequestError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { print(data) }
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}
