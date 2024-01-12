//
//  UIStackView + Extension.swift
//  HotelApp
//
//  Created by Dmitry on 24.12.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
