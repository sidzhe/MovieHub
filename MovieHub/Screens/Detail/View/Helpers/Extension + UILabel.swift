//
//  Extension + UILabel.swift
//  MovieHub
//
//  Created by Igor Guryan on 27.12.2023.
//

import UIKit

extension UILabel {
    static func movieInfoLabel(_ text: String) -> UILabel {
        let view = UILabel()
        view.font = .montserratMedium(size: 12)
        view.textColor = .primaryGray
        view.text = text
        return view
    }
}
