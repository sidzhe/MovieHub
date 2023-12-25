//
//  NetwrorkService.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

//MARK: - NetworkServiceProtool
protocol NetworkServiceProtool: AnyObject {
    func searchTitle<T: Decodable>(_ title: String, completion: @escaping (Result<T, RequestError>) -> Void)
}


//MARK: - NetworkkService
final class NetworkkService: NetworkServiceProtool {
    
    //MARK: Properties
    private let movieService = MovieService()
    
    //MARK: Search with title
    func searchTitle<T: Decodable>(_ title: String, completion: @escaping (Result<T, RequestError>) -> Void) {
        Task {
            let result: Result<T, RequestError> = await movieService.searchMovie(searchTitle: title)
            completion(result)
        }
    }
    
    func loadImage(_ urlString: String?, completion: @escaping (Result<UIImage, RequestError>) -> Void) {
        Task {
            let result: Result<UIImage, RequestError> = await movieService.loadImage(urlString)
            completion(result)
        }
    }
}
