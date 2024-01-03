//
//  AwardsModel.swift
//  MovieHub
//
//  Created by sidzhe on 03.01.2024.
//

import Foundation

// MARK: - AwardsModel
struct AwardsModel: Decodable {
    let docs: [DocAwards]
    let total, limit, page, pages: Int
}

// MARK: - Doc
struct DocAwards: Decodable {
    let personID: Int?
    let nomination: Nomination?
    let movie: Movie?
    let winning: Bool?
    let createdAt, updatedAt, id: String?
}

// MARK: - Nomination
struct Nomination: Decodable {
    let award: Award?
    let title: String?
}

// MARK: - Award
struct Award: Decodable {
    let title: String?
    let year: Int?
}
