//
//  SearchResultSection.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 07.01.2024.
//

import Foundation

enum SearchResultSection: Int {
    case person
    case movie
    
    var title: String {
        switch self {
        case .person:
            return "Actors"
        case .movie:
            return "Movie Related"
        }
    }
}

struct SearchResultSectionData {
    static let shared = SearchResultSectionData()
    
    private let person = SearchResultSection.person
    private let movie = SearchResultSection.movie
    var sectionsArray: [SearchResultSection] {
        [person, movie]
    }
}
