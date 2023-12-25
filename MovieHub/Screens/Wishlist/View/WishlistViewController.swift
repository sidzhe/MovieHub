//
//  WishlistViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class WishlistViewController: UIViewController {
    
    //MARK: Properties
    var presenter: WishlistPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
    }
}


//MARK: - Extension WishlistViewProtocol
extension WishlistViewController: WishlistViewProtocol {
    
}
