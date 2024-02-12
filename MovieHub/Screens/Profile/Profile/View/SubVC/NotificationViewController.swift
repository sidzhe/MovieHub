//
//  NotificationViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 25.01.2024.
//

import UIKit

final class NotificationViewController: UIViewController {
    //MARK: Properties
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryDark
        title = "Уведомления"
        navigationController?.navigationBar.topItem?.title = ""
    }
}
