//
//  MovieClient.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

//MARK: - MovieClient Protocol
protocol MovieClient {
    func sendRequest<T: Decodable>(urlComponents: URLComponents, endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}


//MARK: - Extension MovieClient
extension MovieClient {
    
    func sendRequest<T: Decodable>(urlComponents: URLComponents, endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
       
        guard let url = urlComponents.url else { return .failure(.invalidURL)}
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
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
}
