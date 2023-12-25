//
//  MovieService.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

//MARK: - MovieServiceProtool
protocol MovieServiceProtool {
    func searchMovie<T: Decodable>(searchTitle: String) async -> Result<T, RequestError>
}


//MARK: - MovieService
struct MovieService: MovieServiceProtool, MovieClient {

    func searchMovie<T: Decodable>(searchTitle: String) async -> Result<T, RequestError> {
        return await sendRequest(endpoint: MovieEndpoints.searchTitle, responseModel: T.self, searchTitle: searchTitle)
    }
}
