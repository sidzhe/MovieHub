//
//  ItemSearch.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.12.2023.
//

import Foundation

struct ItemSearch {
    let identifier = UUID()
    
    var search: Doc?
    var categories: SearchCategoryModel?
    var upcomingMovie: Doc?
    var recentMovie: Doc?
}
