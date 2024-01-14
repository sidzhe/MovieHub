//
//  GaleryModel.swift
//  MovieHub
//
//  Created by sidzhe on 13.01.2024.
//

import Foundation

// MARK: - GaleryModel
struct GaleryModel: Hashable, Decodable {
    let docs: [GaleryDoc]
}

// MARK: - Doc
struct GaleryDoc: Hashable, Decodable {
    let url: String?
}
