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
    
    var header: [String : String]? { ["X-API-KEY" : "QC4AKM6-2YZ42H6-NQT8M9Z-P1MC2JP"] }
    
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
