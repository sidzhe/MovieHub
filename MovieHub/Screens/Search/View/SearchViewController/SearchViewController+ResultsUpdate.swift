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
        
        guard let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        resultController.updateInfoImageViewVisibility()
        searchDelayTimer?.invalidate()
        
        searchDelayTimer = Timer.scheduledTimer(withTimeInterval: searchDelayInterval, repeats: false, block: { [weak self] _ in
            
            self?.presenter?.fetchSearchedMovie(with: searchText)
            resultController.searchedMovie = self?.presenter?.getSearchData() ?? []
            
            self?.presenter?.fetchSearchedPerson(with: searchText)
            resultController.searchedPerson = self?.presenter?.getSearchPerson() ?? []
            
            resultController.collectionView.reloadData()
        })
    }
}
