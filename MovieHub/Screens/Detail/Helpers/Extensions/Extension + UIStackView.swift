//
//  Extension + UIStackView.swift
//  MovieHub
//
//  Created by Igor Guryan on 28.12.2023.
//

import UIKit

extension UIStackView {
    static func moviewInfoStack(spacing: CGFloat) -> UIStackView {
        let st = UIStackView()
        st.axis = .horizontal
        st.spacing = spacing
        return st
    }
}
