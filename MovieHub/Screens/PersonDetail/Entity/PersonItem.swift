//
//  PersonItem.swift
//  MovieHub
//
//  Created by sidzhe on 04.01.2024.
//

import Foundation

struct PersonItem: Hashable {
    var facts: String?
    var awards: DocAwards?
    var movies: Doc?
    let identifier = UUID()
}
