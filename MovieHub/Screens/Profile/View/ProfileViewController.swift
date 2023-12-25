//
//  ProfileViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK: Properties
    var presenter: ProfilePresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        
    }
}


//MARK: - Extension ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    
}
