//
//  Section.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.12.2023.
//

import Foundation

enum SearchSection: Int {
    case upcomingMovies
    case recentMovies
  
    var title: String {
        switch self {
        case .upcomingMovies:
            return "Премьеры"
        case .recentMovies:
            return "Просмотренное"
        }
    }
}

struct SearchSectionData {
    static let shared = SearchSectionData()
    
    private let upcomingMovies = SearchSection.upcomingMovies
    private let recentMovies = SearchSection.recentMovies
    var sectionsArray: [SearchSection] {
        [upcomingMovies, recentMovies]
    }
}