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
    func movieFilter<T: Decodable>(slugTag: String) async -> Result<T, RequestError>
    func loadImage(_ urlString: String?) async -> Result<UIImage, RequestError>
}


//MARK: - MovieService
struct MovieService: MovieServiceProtool, MovieClient {
    
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
    
    func searchWithId<T: Decodable>(identifier: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.searchId
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path + identifier
        urlComponents.queryItems = endpoint.item
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.searchId, responseModel: T.self)
    }
    
    func searchCollection<T: Decodable>() async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.slugList
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.item
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.slugList, responseModel: T.self)
    }
    
    func movieFilter<T: Decodable>(slugTag: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.movieSlugFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "lists", value: slugTag)]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.slugList, responseModel: T.self)
    }
    
    func loadImage(_ urlString: String?) async -> Result<UIImage, RequestError> {
        return await imageRequest(urlString)
    }
}
