//
//  ItemMovie.swift
//  MovieHub
//
//  Created by sidzhe on 10.01.2024.
//

import Foundation

struct ItemMovie: Hashable {
    var categories: CategoryModel?
    var movies: Doc?
    let identifier = UUID()
}
