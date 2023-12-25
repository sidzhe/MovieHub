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
    func loadImage(_ urlString: String?) async -> Result<UIImage, RequestError>
}


//MARK: - MovieService
struct MovieService: MovieServiceProtool, MovieClient {

    func searchMovie<T: Decodable>(searchTitle: String) async -> Result<T, RequestError> {
        return await sendRequest(endpoint: MovieEndpoints.searchTitle, responseModel: T.self, searchTitle: searchTitle)
    }
    
    func loadImage(_ urlString: String?) async -> Result<UIImage, RequestError> {
        return await imageRequest(urlString)
    }
}
