//
//  DetailModel.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

// MARK: - DetailModel
struct DetailModel: Decodable {
    let id: Int?
    let externalId: ExternalID?
    let name, alternativeName: String?
    let enName: String?
    let names: [Name]?
    let type: String?
    let typeNumber, year: Int?
    let description, shortDescription, slogan: String?
    let status: String?
    let rating, votes: Rating?
    let movieLength: Int?
    let ratingMPAA: String?
    let ageRating: Int?
    let poster, backdrop: Backdrop?
    let genres, countries: [Country]?
    let persons: [Person]?
    let budget: Budget?
    let fees: Fees?
    let sequelsAndPrequels: [SequelsAndPrequel]?
    let watchability: Watchability?
    let top10, top250: Int?
    let facts: [Fact]?
    let similarMovies: [SequelsAndPrequel]?
    let createdAt, updatedAt: String?
    let videos: Videos?
    let premiere: Premiere?
    let ticketsOnSale: Bool?
    let audience: [Audience]?
    let isSeries: Bool?
    let seriesLength: Int?
    let totalSeriesLength: Int?
    let logo: Logo?
    let lists: [String]?
}

// MARK: - Audience
struct Audience: Decodable {
    let count: Int?
    let country: String?
}

// MARK: - Budget
struct Budget: Decodable {
    let value: Int?
    let currency: String?
}

// MARK: - Fact
struct Fact: Decodable {
    let value, type: String?
    let spoiler: Bool?
}

// MARK: - Fees
struct Fees: Decodable {
    let world, usa: Budget?
}

// MARK: - Logo
struct Logo: Hashable, Decodable {
    let url: String?
}

// MARK: - Person
struct Person: Decodable {
    let id: Int?
    let photo: String?
    let name: String?
    let enName, personDescription: String?
    let profession, enProfession: String?
}

// MARK: - Premiere
struct Premiere: Decodable {
    let world, russia: String?
}

// MARK: - SequelsAndPrequel
struct SequelsAndPrequel: Decodable {
    let id: Int?
    let name, alternativeName: String?
    let enName: String?
    let type: String?
    let poster: Backdrop?
    let rating: Rating?
    let year: Int?
}

// MARK: - Videos
struct Videos: Decodable {
    let trailers: [Trailer]?
}

// MARK: - Trailer
struct Trailer: Decodable {
    let url: String?
    let name, site, type: String?
}

// MARK: - Watchability
struct Watchability: Decodable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Decodable {
    let name: String?
    let logo: Logo?
    let url: String?
}
