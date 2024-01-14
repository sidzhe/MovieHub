//
//  CustomNavigationBar.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 14.01.2024.
//

import UIKit

extension UINavigationController {
  
  func setupNavigationBar() {
    navigationBar.barTintColor = .white
    
    let backButtonImage = UIImage(systemName: "chevron.left")
    let alignInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
    navigationBar.backIndicatorImage = backButtonImage?.withAlignmentRectInsets(alignInsets)
    navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigationBar.tintColor = .white
    navigationBar.topItem?.title = ""
    let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationBar.titleTextAttributes = titleAttributes
      
  }
}
