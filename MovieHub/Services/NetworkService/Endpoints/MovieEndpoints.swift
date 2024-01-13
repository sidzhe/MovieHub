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
    case searchDetailById
    case searchMovieById
    case slugList
    case movieFilter
    case personFilter
    case movieWithPerson
    case awards
    case upcoming
}


//MARK: - Extension MovieEndpoints
extension MovieEndpoints: Endpoint {

    var header: [String : String]? { ["X-API-KEY": "PS2CH02-M8W4WWW-JSKN52C-CEB0JZK"] }
    
    //Path
    var path: String {
        switch self {
            
        case .searchTitle:                 return "/v1.4/movie/search"
        case .searchPerson:                return "/v1.4/person/search"
        case .searchDetailById:            return "/v1.4/movie/"
        case .slugList:                    return "/v1.4/list"
        case .movieFilter:                 return "/v1.4/movie"
        case .personFilter:                return "/v1.4/person"
        case .movieWithPerson:             return "/v1.4/movie"
        case .awards:                      return "/v1.4/person/awards"
        case .upcoming:                    return "/v1.4/movie"
        case .searchMovieById:           return "/v1.4/movie"
        }
    }
    
    //Body
    var body: [String : String]? {
        switch self {
            
        case .searchTitle:                return .none
        case .searchPerson:               return .none
        case .searchDetailById:           return .none
        case .slugList:                   return .none
        case .movieFilter:                return .none
        case .personFilter:               return .none
        case .movieWithPerson:            return .none
        case .awards:                     return .none
        case .upcoming:                   return .none
        case .searchMovieById:          return .none
        }
    }
    
    //Item
    var item: [URLQueryItem]? {
        switch self {
            
        case .searchTitle:               return .none
        case .searchPerson:              return .none
        case .searchDetailById:          return [URLQueryItem(name: "limit", value: "10")]
        case .slugList:                  return [URLQueryItem(name: "pages", value: String(Int.random(in: 1...9))),
                                                 URLQueryItem(name: "limit", value: "10"),
                                                 URLQueryItem(name: "notNullFields", value: "cover.url"),
                                                 URLQueryItem(name: "category", value: "Фильмы")]
        case .movieFilter:               return .none
        case .personFilter:              return .none
        case .movieWithPerson:           return .none
        case .awards:                    return .none
        case .upcoming:                  return .none
        case .searchMovieById:         return .none
        }
    }
}
