//
//  PersonDetalModel.swift
//  MovieHub
//
//  Created by sidzhe on 26.12.2023.
//

import Foundation

//MARK: - PersonDetalModel
struct PersonDetalModel: Hashable, Decodable {
    let docs: [PersonDoc]?
}

// MARK: - Doc
struct PersonDoc: Hashable, Decodable {
    let age: Int?
    let birthPlace: [BirthPlace]?
    let birthday: String?
    let enName: String?
    let facts: [BirthPlace]?
    let growth: Int?
    let movies: [Movie]?
    let name: String?
    let photo: String?
    let profession: [BirthPlace]?
    let spouses: [Spouse]?
}

// MARK: - BirthPlace
struct BirthPlace: Hashable, Decodable {
    let value: String?
}

// MARK: - Movie
struct Movie: Hashable, Decodable {
    let id: Int
    let name: String?
    let rating: Double?
    let general: Bool?
    let movieDescription: String?
    let alternativeName: String?
    let enProfession: String?
}

// MARK: - Spouse
struct Spouse: Hashable, Decodable {
    let id: Int?
    let name: String?
    let divorced: Bool?
    let divorcedReason: String?
    let children: Int?
    let relation: String?
}
