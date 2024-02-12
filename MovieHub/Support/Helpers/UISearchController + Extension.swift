//
//  UISearchController + Extension.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 25.12.2023.
//

import UIKit

extension UISearchController {
    static func makeCustomSearchController(navigationController: UINavigationController, placeholder: String, delegate: UISearchResultsUpdating, searchBarDelegate: UISearchBarDelegate) -> UISearchController {
        let searchResultsController = Builder.createSearchResult(with: navigationController)
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = delegate
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate = searchBarDelegate
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.showsScopeBar = false
        
        
        if let searchTF = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchTF.font = UIFont.montserratSemiBold(size: 16)
            searchTF.textColor = UIColor.white
            searchTF.clipsToBounds = true
            searchTF.layer.cornerRadius = 18
            searchTF.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            
        }
        
        return searchController
    }
}

