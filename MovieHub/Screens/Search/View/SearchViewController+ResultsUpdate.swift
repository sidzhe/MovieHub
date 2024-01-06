//
//  SearchViewController+ResultsUpdate.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 05.01.2024.
//

import UIKit

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count >= 2 else { return }
        
        guard let resultController = searchController.searchResultsController as? SearchResultsViewController  else { return }
       // resultController.searchText = searchText
        presenter?.fetchSearchedMovie(with: searchText)
    }
}
