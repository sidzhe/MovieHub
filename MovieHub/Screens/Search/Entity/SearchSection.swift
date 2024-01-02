//
//  Section.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.12.2023.
//

import Foundation

enum SearchSection: Int {
 //   case categories
    case upcomingMovies
    case recentMovies

//    var items: [SearchItem] {
//        switch self {
//        case .categories(let categoryItems):
//            return categoryItems
//        case .upcomingMovies(let upcomingMoviesItems):
//            return upcomingMoviesItems
//        case .recentMovies(let recentMoviesItems):
//            return recentMoviesItems
//        }
//    }
//    
//    var count: Int {
//        items.count
//    }
//    
    var title: String {
        switch self {
        case .upcomingMovies:
            return "Upcoming Movie"
        case .recentMovies:
            return "Recent movie"
        }
    }
}

struct SearchSectionData {
    static let shared = SearchSectionData()
    
 //   private let categories = SearchSection.categories
    private let upcomingMovies = SearchSection.upcomingMovies
    private let recentMovies = SearchSection.recentMovies
    var sectionsArray: [SearchSection] {
        [upcomingMovies, recentMovies]
    }
}
