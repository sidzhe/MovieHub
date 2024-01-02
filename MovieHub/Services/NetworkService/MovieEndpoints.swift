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
    case movieFilter
    case personFilter
    case movieWithPerson
}


//MARK: - Extension MovieEndpoints
extension MovieEndpoints: Endpoint {
    
    //Path
    var path: String {
        switch self {
            
        case .searchTitle:      return "/v1.4/movie/search"
        case .searchPerson:     return "/v1.4/person/search"
        case .searchId:         return "/v1.4/movie/"
        case .slugList:         return "/v1.4/list"
        case .movieFilter:      return "/v1.4/movie"
        case .personFilter:     return "/v1.4/person"
        case .movieWithPerson:  return "/v1.4/movie"
        }
    }
    
    //Body
    var body: [String : String]? {
        switch self {
            
        case .searchTitle:      return .none
        case .searchPerson:     return .none
        case .searchId:         return .none
        case .slugList:         return .none
        case .movieFilter:      return .none
        case .personFilter:     return .none
        case .movieWithPerson:  return .none
        }
    }
    
    //Item
    var item: [URLQueryItem]? {
        switch self {
            
        case .searchTitle:      return .none
        case .searchPerson:     return .none
        case .searchId:         return [URLQueryItem(name: "limit", value: "10")]
        case .slugList:         return [URLQueryItem(name: "pages", value: String(Int.random(in: 1...9))),
                                        URLQueryItem(name: "limit", value: "10"),
                                        URLQueryItem(name: "notNullFields", value: "cover.url")]
        case .movieFilter:      return .none
        case .personFilter:     return .none
        case .movieWithPerson:  return .none
        }
    }
}
