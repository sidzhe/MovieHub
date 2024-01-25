//
//  LanguageViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 25.01.2024.
//

import UIKit

final class LanguageViewController: UIViewController {
    //MARK: Properties

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryDark
        title = "Выбор языка"
        navigationController?.navigationBar.topItem?.title = ""
    }
}
