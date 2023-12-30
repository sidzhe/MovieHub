//
//  MovieService.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

//MARK: - MovieServiceProtool
protocol MovieServiceProtool {
    func searchMovie<T: Decodable>(searchTitle: String) async -> Result<T, RequestError>
    func searchPerson<T: Decodable>(person: String) async -> Result<T, RequestError>
    func searchWithId<T: Decodable>(identifier: String) async -> Result<T, RequestError>
    func searchCollection<T: Decodable>() async -> Result<T, RequestError>
    func movieFilterSlug<T: Decodable>(slugTag: String) async -> Result<T, RequestError>
    func movieFilterGenres<T: Decodable>(genre: String) async -> Result<T, RequestError>
    func movieFilterRate<T: Decodable>(genre: String) async -> Result<T, RequestError>
    func movieFilterPerson<T: Decodable>(actorsId: [Int]) async -> Result<T, RequestError>
}


//MARK: - MovieService
struct MovieService: MovieServiceProtool, MovieClient {
    
    //MARK: Search movie with title
    func searchMovie<T: Decodable>(searchTitle: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.searchTitle
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "query", value: searchTitle), URLQueryItem(name: "limit", value: "10")]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.searchTitle, responseModel: T.self)
    }
    
    //MARK: Search person with name
    func searchPerson<T: Decodable>(person: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.searchPerson
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "query", value: person), URLQueryItem(name: "limit", value: "10")]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.searchPerson, responseModel: T.self)
    }
    
    //MARK: Search movie with id
    func searchWithId<T: Decodable>(identifier: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.searchId
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path + identifier
        urlComponents.queryItems = endpoint.item
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.searchId, responseModel: T.self)
    }
    
    //MARK: Get slug collection
    func searchCollection<T: Decodable>() async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.slugList
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.item
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.slugList, responseModel: T.self)
    }
    
    //MARK: Get collection
    func movieFilterSlug<T: Decodable>(slugTag: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.movieFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "lists", value: slugTag)]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.movieFilter, responseModel: T.self)
    }
    
    //MARK: Gesre's collection
    func movieFilterGenres<T: Decodable>(genre: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.movieFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "genres.name", value: genre)]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.movieFilter, responseModel: T.self)
    }
    
    //MARK: Rated moveies
    func movieFilterRate<T: Decodable>(genre: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.movieFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        var items = [URLQueryItem(name: "page", value: String(Int.random(in: 1...75))),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "rating.kp", value: "4.5-10")]
        if genre != "все" {
            let item = URLQueryItem(name: "genres.name", value: genre)
            items.append(item)
        }
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.movieFilter, responseModel: T.self)
    }
    
    //MARK: Related person
    func movieFilterPerson<T: Decodable>(actorsId: [Int]) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.personFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        var items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "selectFields", value: "movies")]
        let anotherItems = actorsId.map { URLQueryItem(name: "id", value: String($0))}
        items.append(contentsOf: anotherItems)
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.personFilter, responseModel: T.self)
    }
}
