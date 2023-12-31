//
//  Section.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.12.2023.
//

import Foundation

enum SearchSection: Int {
    case categories
    case upcomingMovies
    case recentMovies
    
    var title: String {
        switch self {
        case .categories:
            return ""
        case .upcomingMovies:
            return "Upcoming Movie"
        case .recentMovies:
            return "Recent movie"
        }
    }
}
