//
//  Section.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.12.2023.
//

import Foundation

enum SearchSection {
    case categories([SearchItem])
    case upcomingMovies([SearchItem])
    case recentMovies([SearchItem])
    
    var items: [SearchItem] {
        switch self {
        case .categories(let categoryItems):
            return categoryItems
        case .upcomingMovies(let upcomingMoviesItems):
            return upcomingMoviesItems
        case .recentMovies(let recentMoviesItems):
            return recentMoviesItems
        }
    }
    
    var count: Int {
        items.count
    }
    
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
