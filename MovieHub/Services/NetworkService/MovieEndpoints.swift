//
//  MovieEndpoints.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

//MARK: - MovieEndpoints
enum MovieEndpoints {
    case searchTitle
}


//MARK: - Extension MovieEndpoints
extension MovieEndpoints: Endpoint {
    
    //Host
    var host: RequestHost {
        switch self {
            
        case .searchTitle:  
            return .movieHost
        }
    }
    
    //Path
    var path: String {
        switch self {
            
        case .searchTitle:   
            return "/v1.4/movie/search"
        }
    }
    
    //Mehthod
    var method: RequestMethod {
        switch self {
            
        case .searchTitle:   
            return .get
        }
    }
    
    //Body
    var body: [String : String]? {
        switch self {
            
        case .searchTitle:   
            return .none
        }
    }
    
    //Item
    var item: [URLQueryItem]? {
        switch self {
            
        case .searchTitle:   
            return .none
        }
    }
}
