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
    private let storageService: StorageServiceProtocol
    
    //MARK: Init
    init(networkService: NetworkService, storageService: StorageServiceProtocol, detailID: String) {
        self.networkService = networkService
        self.storageService = storageService
        self.detailID = detailID
        detailRequest()
    }
    
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
    
    //MARK: Check favorites from CD
    func checkFavorites(id: Int) {
        if let userId = try? storageService.getCurrentUser().get() {
            storageService.checkWish(id: id, currentUserID: userId.userID ?? UUID())
        } else {
            print("ошибка получение пользователя для детальной иформации")
        }
    }
    
    //MARK: - Get favorites button state
    func getFavoritesButtonState() -> Bool {
        guard let id = Int(detailID) else { return  false }
        return storageService.wishStateButton(id: id)
    }
    
    //MARK: Check favorites from CD
    func addRecentMovie() {
        guard let id = Int(detailID) else { return }
        if let userId = try? storageService.getCurrentUser().get() {
            storageService.saveRecentModel(id: id, currentUserID: userId.userID ?? UUID())
        } else {
            print("ошибка получение пользователя c детального")
        }
    }
}
