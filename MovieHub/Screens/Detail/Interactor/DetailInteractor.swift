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
    var detailData: DetailModel?
    private var detailID: String
    private let networkService: NetworkService
    
    //MARK: Init
    init(networkService: NetworkService, detailID: String) {
        self.networkService = networkService
        self.detailID = detailID
        detailRequest()
    }
    
    func detailRequest() {
        networkService.searchDetailID(detailID) { [weak self] (result: (Result<DetailModel, RequestError>)) in
            switch result {
                
            case .success(let detail):
                self?.detailData = detail
                self?.presenter?.updateUI()
                print(detail)
            case .failure(let error):
                self?.presenter?.getRequestError(error)
            }
        }
    }

}
