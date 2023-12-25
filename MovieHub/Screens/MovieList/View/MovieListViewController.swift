//
//  MovieListViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    //MARK: Properties
    var presenter: MovieListPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
    }
}


//MARK: - Extension MovieListViewProtocol
extension MovieListViewController: MovieListViewProtocol {
    
}
