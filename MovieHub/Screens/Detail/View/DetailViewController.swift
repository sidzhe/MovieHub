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
    var networkManager = NetworkkService()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch("5304403")
        view.backgroundColor = .purple
        
    }
    
    func fetch(_ id: String) {
        networkManager.searchID(id) {(result: Result<DetailModel, RequestError>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { print(data) }
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}


//MARK: - Extension DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    
}
