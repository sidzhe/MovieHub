//
//  Endpoint.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: RequestHost { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String : String]? { get }
    var body: [String : String]? { get }
    var item: [URLQueryItem]? { get }
}


extension Endpoint {
    var scheme: String { "https" }
    var header: [String: String]? { ["X-API-KEY": "PS2CH02-M8W4WWW-JSKN52C-CEB0JZK"] }
}

enum RequestHost: String {
    case movieHost = "api.kinopoisk.dev"
}
