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
    private var personId: String
    
    //MARK: Init
    init(networkService: NetworkService, personId: String) {
        self.networkService = networkService
        self.personId = personId
    }
    
    //MARK: Person request
    func personRequest() {
//6264
        networkService.searchPerson(personId) { [weak self] (result: (Result<PersonDetalModel, RequestError>)) in
            switch result {
                
            case .success(let person):
                print(person)
            case .failure(let error):
                print(error)
            }
        }
    }
}
