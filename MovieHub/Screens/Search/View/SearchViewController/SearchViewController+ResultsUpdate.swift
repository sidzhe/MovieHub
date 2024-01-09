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
        guard let searchText = searchController.searchBar.text, searchText.count >= 2,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
 
//        searchDelayTimer?.invalidate()
        
        searchDelayTimer = Timer.scheduledTimer(withTimeInterval: searchDelayInterval, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.fetchSearchedMovie(with: searchText)
            self.presenter?.fetchSearchedPerson(with: searchText)
            
            resultController.updateSearchData(
                searchedMovie: self.presenter?.getSearchData(),
                searchedPerson: self.presenter?.getSearchPerson()
            )
        })
        
        resultController.updateInfoImageViewVisibility()
    }
}
