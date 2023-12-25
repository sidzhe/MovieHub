//
//  MainViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: Properties
    var presenter: MainPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
    }
}


//MARK: - Extension MainViewProtocol
extension MainViewController: MainViewProtocol {
    
}
