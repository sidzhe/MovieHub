//
//  GlobeItem.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation

struct GlobeItem: Hashable {
    var city: String?
    var cinemaMap: String?
    var cinema: GlobeCinema?
    let identifier = UUID()
}
