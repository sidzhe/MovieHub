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
    case searchId
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
        case .searchId:
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
        case .searchId:
            return "/v1.4/movie/"
        }
    }
    
    //Mehthod
    var method: RequestMethod {
        switch self {
            
        case .searchTitle:   
            return .get
        case .searchPerson:
            return .get
        case .searchId:
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
        case .searchId:
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
        case .searchId:
            let item = [URLQueryItem(name: "limit", value: "10")]
            return item
        }
    }
}
