//
//  CollectionDetailModel.swift
//  MovieHub
//
//  Created by sidzhe on 26.12.2023.
//

import Foundation

// MARK: - CollectionDetailModel
struct CollectionDetailModel: Hashable, Decodable {
    let docs: [Doc]?
    let total, limit, page, pages: Int?
}
