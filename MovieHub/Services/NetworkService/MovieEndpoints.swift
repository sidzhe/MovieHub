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
    case slugList
}


//MARK: - Extension MovieEndpoints
extension MovieEndpoints: Endpoint {
    
    //Path
    var path: String {
        switch self {
            
        case .searchTitle:    return "/v1.4/movie/search"
        case .searchPerson:   return "/v1.4/person/search"
        case .searchId:       return "/v1.4/movie/"
        case .slugList:       return "/v1.4/list"
            
        }
    }
    
    //Mehthod
    var method: RequestMethod {
        switch self {
            
        case .searchTitle:    return .get
        case .searchPerson:   return .get
        case .searchId:       return .get
        case .slugList:       return .get
            
        }
    }
    
    //Body
    var body: [String : String]? {
        switch self {
            
        case .searchTitle:    return .none
        case .searchPerson:   return .none
        case .searchId:       return .none
        case .slugList:       return .none
            
        }
    }
    
    //Item
    var item: [URLQueryItem]? {
        switch self {
            
        case .searchTitle:    return .none
        case .searchPerson:   return .none
        case .searchId:       return [URLQueryItem(name: "limit", value: "10")]
        case .slugList:       return [URLQueryItem(name: "pages", value: String(Int.random(in: 1...9))), URLQueryItem(name: "limit", value: "10")]
             
        }
    }
}
