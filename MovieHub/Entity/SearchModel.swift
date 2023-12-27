//
//  SearchModel.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Hashable, Decodable {
    let docs: [Doc]
    let total, limit, page, pages: Int
}

// MARK: - Doc
struct Doc: Hashable, Decodable {
    let id: Int?
    let name, alternativeName, enName: String?
    let type: String?
    let year: Int?
    let docDescription, shortDescription: String?
    let movieLength: Int?
    let isSeries, ticketsOnSale: Bool?
    let totalSeriesLength: Int?
    let seriesLength: Int?
    let ratingMPAA: String?
    let ageRating: Int?
    let top10: Int?
    let top250: Int?
    let typeNumber: Int?
    let status: String?
    let names: [Name]?
    let externalId: ExternalID?
    let poster, backdrop: Backdrop?
    let rating, votes: Rating?
    let genres, countries: [Country]?
    let releaseYears: [ReleaseYear]?
}

// MARK: - Backdrop
struct Backdrop: Hashable, Decodable {
    let url, previewURL: String?
}

// MARK: - Country
struct Country: Hashable, Decodable {
    let name: String?
}

// MARK: - ExternalID
struct ExternalID: Hashable, Decodable {
    let tmdb: Int?
    let kpHD, imdb: String?
}

// MARK: - Name
struct Name: Hashable, Decodable {
    let name: String?
    let language: String?
    let type: String?
}

// MARK: - Rating
struct Rating: Hashable, Decodable {
    let kp, imdb, filmCritics, russianFilmCritics: Double?
    let await: Int?
}

// MARK: - ReleaseYear
struct ReleaseYear: Hashable, Decodable {
    let start, end: Int?
}

