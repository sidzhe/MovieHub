//
//  PoliciesViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 12.01.2024.
//

import UIKit

final class PoliciesViewController: UIViewController {
    
    //MARK: Properties

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryDark
        title = "Правила"
        navigationController?.navigationBar.topItem?.title = ""
    }
}

