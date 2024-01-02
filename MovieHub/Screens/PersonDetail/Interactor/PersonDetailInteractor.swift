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
    private let networkService: NetworkService
    private var personId: [Int]
    var searchData: SearchModel?
    var personDetailData: PersonDetalModel?
    
    //MARK: Init
    init(networkService: NetworkService, personId: [Int]) {
        self.networkService = networkService
        self.personId = personId
        personRequest()
//        movieWithPersonRequest()
    }
    
    //MARK: Person request
    func personRequest() {
        //6264
        networkService.getDetailPerson(personId: personId) { [weak self] (result: (Result<PersonDetalModel, RequestError>)) in
            switch result {
                
            case .success(let person):
                self?.personDetailData = person
                print(person)
            case .failure(let error):
                self?.presenter?.getRequestError(error)
            }
        }
    }
    
    //MARK: Movie with person
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
}
