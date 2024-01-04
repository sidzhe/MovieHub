//
//  UISearchController + Extension.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 25.12.2023.
//

import UIKit

extension UISearchController {
    static func makeCustomSearchController(
        placeholder: String,
        delegate: UISearchResultsUpdating) -> UISearchController {
        
        let searchResultsController = SearchResultsViewController()
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = delegate
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            textField.textColor = .white
            textField.clipsToBounds = true
            textField.layer.cornerRadius = 18
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
        
    return searchController
    }
}

