//
//  MovieClient.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

//MARK: - MovieClient Protocol
protocol MovieClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, searchTitle: String) async -> Result<T, RequestError>
    func imageRequest(_ urlString: String?) async -> Result<UIImage, RequestError>
}


//MARK: - Extension MovieClient
extension MovieClient {
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type, searchTitle: String) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.rawValue
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "query", value: searchTitle), URLQueryItem(name: "limit", value: "10")]
        urlComponents.queryItems = items
        
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else { return .failure(.noResponse)}
            
            switch response.statusCode {
                
            case 200...299:
                guard let decode = try? JSONDecoder().decode(responseModel, from: data) else { return .failure(.decode)}
                return .success(decode)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    // Load Image
    func imageRequest(_ urlString: String?) async -> Result<UIImage, RequestError> {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return .failure(.invalidURL)
        }
        
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
        
        do {
            if let cachedResponse = URLCache.shared.cachedResponse(for: request),
               let cachedImage = UIImage(data: cachedResponse.data) {
                return .success(cachedImage)
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let image = UIImage(data: data) else {
                    return .failure(.unexpectedStatusCode)
                }
                
                let cachedResponse = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedResponse, for: request)
                
                return .success(image)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
