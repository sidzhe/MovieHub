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
    
    
    //MARK: Detail request
    func detailRequest() {
        networkService.searchDetailID(detailID) { [weak self] (result: (Result<DetailModel, RequestError>)) in
            
            switch result {
            case .success(let detail):
                self?.detailData = detail
                self?.presenter?.updateUI()
            case .failure(let error):
                self?.presenter?.getRequestError(error)
            }
        }
    }

}
