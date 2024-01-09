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
    var method: String { get }
    var header: [String : String]? { get }
    var body: [String : String]? { get }
    var item: [URLQueryItem]? { get }
}


extension Endpoint {
    var scheme: String { "https" }
    var host: String { "api.kinopoisk.dev" }
    var method: String { "GET" }
}
