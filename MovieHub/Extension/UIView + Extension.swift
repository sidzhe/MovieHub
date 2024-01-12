//
//  UIView + Extension.swift
//  HotelApp
//
//  Created by Dmitry on 21.12.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
