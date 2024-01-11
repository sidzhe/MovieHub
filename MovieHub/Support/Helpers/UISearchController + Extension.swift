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
        
            let searchResultsController = Builder.createSearchResult()
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = delegate
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.montserratSemiBold(size: 16)
            textField.textColor = UIColor.white
            textField.clipsToBounds = true
            textField.layer.cornerRadius = 18
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
        
        return searchController
    }
}

