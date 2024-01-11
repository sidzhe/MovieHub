//
//  CinemaEndpoints.swift
//  MovieHub
//
//  Created by sidzhe on 05.01.2024.
//

import Foundation

//MARK: - CinemaEndpoints
enum CinemaEndpoints {
    case getMovieList
}


//MARK: - Extension CinemaEndpoints
extension CinemaEndpoints: Endpoint {
    
    var header: [String : String]? { ["X-API-KEY": "e6e8d8a5a3d9dfdad15218b4150e1b89ce3d399a148b9f0dc07a4650b9b5e66c"] }
    
    //Path
    var path: String {
        switch self {
            
        case .getMovieList:      return "/v2/cinema/$"
        }
    }
    
    //Body
    var body: [String : String]? {
        switch self {
            
        case .getMovieList:      return .none
        }
    }
    
    //Item
    var item: [URLQueryItem]? {
        switch self {
            
        case .getMovieList:      return .none

        }
    }
}
