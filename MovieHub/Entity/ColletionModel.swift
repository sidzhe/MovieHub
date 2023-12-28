//
//  ColletionModel.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

// MARK: - ColletionModel
struct ColletionModel: Decodable {
    let docs: [DocCollect]
    let total, limit, page, pages: Int
}

// MARK: - Doc
struct DocCollect: Decodable {
    let category, name, slug, createdAt: String
    let updatedAt, id: String
    let moviesCount: Int?
    let cover: Cover?
}

// MARK: - Cover
struct Cover: Decodable {
    let url, previewUrl: String
}


