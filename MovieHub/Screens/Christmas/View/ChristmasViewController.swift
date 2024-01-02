//
//  ChristmasViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class ChristmasViewController: UIViewController {
    
    //MARK: Properties
    var presenter: ChristmasPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        
    }
}


//MARK: - Extension ChristmasViewProtocol
extension ChristmasViewController: ChristmasViewProtocol {
    
}
