//
//  SearchResultSection.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 07.01.2024.
//

import Foundation

enum SearchResultSection: Int, CaseIterable {
    case person
    case movie
}

struct SearchResultSectionData {
    static let shared = SearchResultSectionData()
    
    private let person = SearchResultSection.person
    private let movie = SearchResultSection.movie
    var sectionsArray: [SearchResultSection] {
        [person, movie]
    }
}
