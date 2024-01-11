//
//  CurrentCityModel.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation

// MARK: - CurrentCityModel
struct CurrentCityModel: Decodable {
    let response: Response?
}

// MARK: - Response
struct Response: Decodable {
    let geoObjectCollection: GeoObjectCollection?
    
    enum CodingKeys: String, CodingKey {
          case geoObjectCollection = "GeoObjectCollection"
      }
}

// MARK: - GeoObjectCollection
struct GeoObjectCollection: Decodable {
    let featureMember: [FeatureMember]?
}

// MARK: - FeatureMember
struct FeatureMember: Decodable {
    let geoObject: GeoObject?
    
    enum CodingKeys: String, CodingKey {
         case geoObject = "GeoObject"
     }
}

// MARK: - GeoObject
struct GeoObject: Decodable {
    let name: String?
    let geoObjectDescription: String?
    let uri: String?
    let point: Point?
    
    enum CodingKeys: String, CodingKey {
         case name, geoObjectDescription, uri
         case point = "Point"
     }
}

struct Point: Decodable {
    let pos: String
}

