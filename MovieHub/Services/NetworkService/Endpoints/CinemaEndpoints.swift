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
    
    var header: [String : String]? { ["X-API-KEY": "6RPBT9S-1R74EQQ-M20AAQK-EFE511M"] }
    
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
