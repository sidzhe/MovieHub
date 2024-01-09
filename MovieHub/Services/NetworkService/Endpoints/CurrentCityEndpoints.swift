//
//  CurrentCityEndpoints.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation

//MARK: - CurrentCityEndpoints
enum CurrentCityEndpoints {
    case getCurrentCity
}


//MARK: - Extension CurrentCityEndpoints
extension CurrentCityEndpoints: Endpoint {
    
    var header: [String : String]? {
        return nil
    }
    
    //Path
    var path: String {
        switch self {
            
        case .getCurrentCity:
            return "/1.x"
        }
    }
    
    //Body
    var body: [String : String]? {
        switch self {
            
        case .getCurrentCity:
            return .none
        }
    }
    
    //Item
    var item: [URLQueryItem]? {
        switch self {
            
        case .getCurrentCity:
            return .none
        }
    }
}
