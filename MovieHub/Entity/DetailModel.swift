//
//  DetailModel.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

// MARK: - DetailModel
struct DetailModel: Hashable, Decodable {
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
    let sequelsAndPrequels: [SequelsPrequel]?
    let watchability: Watchability?
    let top10, top250: Int?
    let facts: [Fact]?
    let similarMovies: [SequelsPrequel]?
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
struct Audience: Hashable, Decodable {
    let count: Int?
    let country: String?
}

// MARK: - Budget
struct Budget: Hashable, Decodable {
    let value: Int?
    let currency: String?
}

// MARK: - Fact
struct Fact: Hashable, Decodable {
    let value, type: String?
    let spoiler: Bool?
}

// MARK: - Fees
struct Fees: Hashable, Decodable {
    let world, usa: Budget?
}

// MARK: - Logo
struct Logo: Hashable, Decodable {
    let url: String?
}

// MARK: - Person
struct Person: Hashable, Decodable {
    let id: Int?
    let photo: String?
    let name: String?
    let enName, personDescription: String?
    let profession, enProfession: String?
}

// MARK: - Premiere
struct Premiere: Hashable, Decodable {
    let world, russia: String?
}

// MARK: - SequelsAndPrequel
struct SequelsPrequel: Hashable, Decodable {
    let id: Int?
    let name, alternativeName: String?
    let enName: String?
    let type: String?
    let poster: Backdrop?
    let rating: Rating?
    let year: Int?
}

// MARK: - Videos
struct Videos: Hashable, Decodable  {
    let trailers: [Trailer]?
}

// MARK: - Trailer
struct Trailer: Hashable, Decodable {
    let url: String?
    let name, site, type: String?
}

// MARK: - Watchability
struct Watchability: Hashable, Decodable {
    let items: [Item]?
}

// MARK: - Item
struct Item: Hashable, Decodable {
    let name: String?
    let logo: Logo?
    let url: String?
}
