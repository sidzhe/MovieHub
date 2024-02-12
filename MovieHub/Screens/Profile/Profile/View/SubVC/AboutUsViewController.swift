//
//  AboutUsViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 12.01.2024.
//

import UIKit

final class AboutUsViewController: UIViewController {
    
    //MARK: Properties

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryDark
        title = "О нас"
        navigationController?.navigationBar.topItem?.title = ""
    }
}
