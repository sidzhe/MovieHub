//
//  NavigationController + Extension.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 25.12.2023.
//

import UIKit

extension UINavigationController {
    
    func setupNavigationBar() {
        let backButtonImage = UIImage(systemName: "arrow.left")
        let alignInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        navigationBar.backIndicatorImage = backButtonImage?.withAlignmentRectInsets(alignInsets)
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationBar.tintColor = .white
    }
}
