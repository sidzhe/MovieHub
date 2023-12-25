//
//  SearchViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    //MARK: Properties
    var presenter: SearchPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
    }
}


//MARK: - Extension SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    
}
