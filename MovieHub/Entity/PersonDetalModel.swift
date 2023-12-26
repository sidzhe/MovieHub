//
//  PersonDetalModel.swift
//  MovieHub
//
//  Created by sidzhe on 26.12.2023.
//

import Foundation

//MARK: - PersonDetalModel
struct PersonDetalModel: Decodable {
    let docs: [PersonDoc]?
}

// MARK: - Doc
struct PersonDoc: Decodable {
    let movies: [Movie]?
}

// MARK: - Movie
struct Movie: Decodable {
    let id: Int
    let name: String?
    let rating: Double?
    let general: Bool?
    let movieDescription: String?
    let alternativeName: String?
    let enProfession: String?
}
