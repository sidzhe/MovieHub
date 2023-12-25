//
//  PopularViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class PopularViewController: UIViewController {
    
    //MARK: Properties
    var presenter: PopularPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
    }
}


//MARK: - Extension PopularViewProtocol
extension PopularViewController: PopularViewProtocol {
    
}
