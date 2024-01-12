//
//  GlobeCinema.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation

struct GlobeCinema: Hashable {
    let distance: Double
    let name: String
    let adress: String
    var image: [String]? = nil
    var description: String? = nil
    var phone: String? = nil
}
