//
//  CollectionInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import Foundation

final class CollectionInteractor: CollectionInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: CollectionInteractorOutputProtocol?
    var networkService: NetworkServiceProtocol
    var collectionData: SearchModel?
    private var slug: String
    
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol, slug: String) {
        self.networkService = networkService
        self.slug = slug
        self.getCollection()
    }
    
    //MARK: Collection request
    func getCollection() {
        networkService.getSlugCollection(slugTag: slug) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            
            switch result {
            case .success(let data):
                self?.collectionData = data
                self?.presenter?.updateUI()
            case .failure(let error):
                self?.presenter?.getError(error.customMessage)
            }
        }
    }
}
