//
//  PersonDetailInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import Foundation

final class PersonDetailInteractor: PersonDetailInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: PersonDetailInteractorOutputProtocol?
    private let networkService: NetworkServiceProtocol
    private var personId: Int
    var searchData: SearchModel?
    var personDetailData: PersonDetailModel?
    var awardsData: AwardsModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol, personId: Int) {
        self.networkService = networkService
        self.personId = personId
        personRequest()
        awardsRequest()
        movieWithPersonRequest()
    }
    
    //MARK: Person request
    func personRequest() {
        networkService.getDetailPerson(personId: [personId]) { [weak self] (result: (Result<PersonDetailModel, RequestError>)) in
            
            switch result {
            case .success(let person):
                self?.personDetailData = person
                self?.presenter?.updateUI()
            case .failure(let error):
                self?.presenter?.getRequestError(error)
            }
        }
    }
    
    //MARK: Movie with person request
    func movieWithPersonRequest() {
        networkService.getMovieWithPerson(personId: personId) { [weak self] (result: (Result<SearchModel, RequestError>)) in
            switch result {
                
            case .success(let movies):
                self?.searchData = movies
                self?.presenter?.updateUI()
            case .failure(let error):
                self?.presenter?.getRequestError(error)
            }
        }
    }
    
    //MARK: Awards request
    func awardsRequest() {
        networkService.getAwardsPerson(personId: personId) { [weak self] (result: (Result<AwardsModel, RequestError>)) in
            switch result {
                
            case .success(let awards):
                self?.awardsData = awards
                self?.presenter?.updateUI()
            case .failure(let error):
                self?.presenter?.getRequestError(error)
            }
        }
    }
}
