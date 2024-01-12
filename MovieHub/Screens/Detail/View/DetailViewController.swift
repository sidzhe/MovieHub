//
//  DetailViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: Properties
    var presenter: DetailPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
    }
}


//MARK: - Extension DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    
}
