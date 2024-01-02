//
//  Endpoint.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String : String]? { get }
    var body: [String : String]? { get }
    var item: [URLQueryItem]? { get }
}


extension Endpoint {
    var scheme: String { "https" }
    var host: String { "api.kinopoisk.dev" }
    var header: [String: String]? { ["X-API-KEY": "TWDAGHF-7N7407Z-KY20SE0-7ACQ6FD"] }
}
