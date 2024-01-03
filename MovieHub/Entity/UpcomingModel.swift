//
//  UpcomingModel.swift
//  MovieHub
//
//  Created by sidzhe on 03.01.2024.
//

import Foundation

// MARK: - UpcomingModel
struct UpcomingModel: Decodable {
    let docs: [UpcomingDoc]?
    let total, limit, page, pages: Int?
}

// MARK: - UpcomingDoc
struct UpcomingDoc: Decodable {
    let sequelsAndPrequels: [SequelsAndPrequel]?
}

// MARK: - SequelsAndPrequel
struct SequelsAndPrequel: Decodable {
    let id: Int?
    let name, alternativeName, enName: String?
    let type: String?
    let poster: Poster?
    let rating: Rating?
    let year: Int?
}

// MARK: - Poster
struct Poster: Decodable {
    let url, previewURL: String?
}


