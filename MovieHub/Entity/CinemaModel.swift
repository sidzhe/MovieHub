//
//  CinemaModel.swift
//  MovieHub
//
//  Created by sidzhe on 05.01.2024.
//

import Foundation

// MARK: - CinemaModel
struct CinemaModel: Hashable, Decodable {
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Hashable, Decodable {
    let data: CinemaDatumModel?
}

// MARK: - DataClass
struct CinemaDatumModel: Hashable, Decodable {
    let general: General?
}

// MARK: - General
struct General: Hashable, Decodable {
    let name, generalDescription: String?
    let address: Address?
    let contacts: Contacts?
    let externalInfo: [ExternalInfo]?
    let image: Image?
    let gallery: [Image]?
    let description: String?
}

// MARK: - Address
struct Address: Hashable, Decodable {
    let street: String?
    let comment, fiasHouseID, fiasStreetID, fiasCityID: String?
    let fiasRegionID: String?
    let fullAddress: String?
    let mapPosition: MapPosition?
}

// MARK: - MapPosition
struct MapPosition: Hashable, Decodable {
    let coordinates: [Double]?
}

// MARK: - Contacts
struct Contacts: Hashable, Decodable {
    let phones: [Phone]?
    let website: String?
    let email: String?
}

// MARK: - Phone
struct Phone: Hashable, Decodable {
    let value: String
}

// MARK: - ExternalInfo
struct ExternalInfo: Hashable, Decodable {
    let url: String?
    let serviceName: String?
}

// MARK: - Image
struct Image: Hashable, Decodable {
    let url: String?
    let title: String?
}

