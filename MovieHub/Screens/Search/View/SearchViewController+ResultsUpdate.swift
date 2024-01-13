//
//  SearchViewController+ResultsUpdate.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 05.01.2024.
//

import UIKit

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.isActive else { return }
        guard let searchText = searchController.searchBar.text, searchText.count >= 2,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        searchDelayTimer?.invalidate()
        searchDelayTimer = Timer.scheduledTimer(withTimeInterval: searchDelayInterval, repeats: false, block: { [weak self] _ in
            guard self != nil else { return }
            resultController.presenter?.updateSearchResults(with: searchText)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //        searchController.isActive = false
        //        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
}
