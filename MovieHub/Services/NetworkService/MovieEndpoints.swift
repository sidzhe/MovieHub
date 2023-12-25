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
    case searchPerson
}


//MARK: - Extension MovieEndpoints
extension MovieEndpoints: Endpoint {
    
    //Host
    var host: RequestHost {
        switch self {
            
        case .searchTitle:  
            return .movieHost
        case .searchPerson:
            return .movieHost
        }
    }
    
    //Path
    var path: String {
        switch self {
            
        case .searchTitle:   
            return "/v1.4/movie/search"
        case .searchPerson:
            return "/v1.4/person/search"
        }
    }
    
    //Mehthod
    var method: RequestMethod {
        switch self {
            
        case .searchTitle:   
            return .get
        case .searchPerson:
            return .get
        }
    }
    
    //Body
    var body: [String : String]? {
        switch self {
            
        case .searchTitle:   
            return .none
        case .searchPerson:
            return .none
        }
    }
    
    //Item
    var item: [URLQueryItem]? {
        switch self {
            
        case .searchTitle:   
            return .none
        case .searchPerson:
            return .none
        }
    }
}
