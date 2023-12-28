//
//  ItemMain.swift
//  MovieHub
//
//  Created by sidzhe on 27.12.2023.
//

import Foundation

struct ItemMain: Hashable {
    var collection: DocCollect?
    var categories: CategoryModel?
    var popular: Doc?
    let identifier = UUID()
}
