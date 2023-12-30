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
        case .categories(let items),
                .upcomingMovies(let items),
                .recentMovies(let items):
            return items
        }
    }
}
