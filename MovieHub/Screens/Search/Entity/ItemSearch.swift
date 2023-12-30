//
//  ItemSearch.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.12.2023.
//

import Foundation

struct ItemSearch {
    var search: Doc?
    var categories: SearchCategoryModel?
    var recentMovie: Doc?
    let identifier = UUID()
}
