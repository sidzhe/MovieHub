//
//  MockNetworkService.swift
//  MovieHub
//
//  Created by sidzhe on 10.02.2024.
//

import Foundation

final class MockNetworkService: NetworkServiceProtocol, Mockable {
    
    func searchMovieByTitle(_ title: String, completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
        
    }
    
    func searchPerson(_ person: String, completion: @escaping (Result<PersonModel, RequestError>) -> Void) {
        
    }
    
    func searchDetailID(_ identifier: String, completion: @escaping (Result<DetailModel, RequestError>) -> Void) {
        let data = getJSON(fileName: "ChrimtmasInteractorJson", type: DetailModel.self)
        completion(.success(data))
    }
    
    func searchColletions(completion: @escaping (Result<ColletionModel, RequestError>) -> Void) {
        
    }
    
    func getSlugCollection<T>(slugTag: String, completion: @escaping (Result<T, RequestError>) -> Void) where T : Decodable {
        
    }
    
    func getGenreCollection(genre: MovieGenre, completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
        
    }
    
    func getRateCollection(genre: MovieGenre, completion: @escaping (Result<CollectionDetailModel, RequestError>) -> Void) {
        
    }
    
    func getDetailPerson(personId: [Int], completion: @escaping (Result<PersonDetalModel, RequestError>) -> Void) {
        
    }
    
    func getMovieWithPerson(personId: Int, completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
        
    }
    
    func getAwardsPerson(personId: Int, completion: @escaping (Result<AwardsModel, RequestError>) -> Void) {
        
    }
    
    func getMovieUpcomingByGenres(genre: MovieGenre, completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
        
    }
    
    func getCityList(city: String, completion: @escaping (Result<CinemaModel, RequestError>) -> Void) {
        
    }
    
    func getCurrentCity(city: String, completion: @escaping (Result<CurrentCityModel, RequestError>) -> Void) {
        
    }
    
    func searchMovieById(identifiers: [String], completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
        
    }
}