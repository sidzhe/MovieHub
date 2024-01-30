//
//  AuthViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.01.2024.
//

import UIKit

final class AuthViewController: UIViewController {
    //MARK: Properties
    var presenter: AuthPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension AuthViewController: AuthViewProtocol {
    
    
}
