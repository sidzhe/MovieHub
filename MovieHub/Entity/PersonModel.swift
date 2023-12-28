//
//  PersonModel.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

// MARK: - PersonModel
struct PersonModel: Decodable {
    let docs: [DocPerson]
}

// MARK: - Doc
struct DocPerson: Decodable {
    let id: Int
    let name, enName: String
    let photo: String
}
