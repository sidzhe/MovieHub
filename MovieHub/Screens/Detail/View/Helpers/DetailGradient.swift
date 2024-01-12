//
//  DetailGradient.swift
//  MovieHub
//
//  Created by Igor Guryan on 27.12.2023.
//

import UIKit

class GradientView: UIView {
    var topColor: CGColor = UIColor(red: 0.122, green: 0.114, blue: 0.169, alpha: 0.2).cgColor
    var bottomColor: CGColor = UIColor(red: 0.122, green: 0.114, blue: 0.169, alpha: 1).cgColor
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }

    override func layoutSubviews() {
        (layer as! CAGradientLayer).colors = [topColor, bottomColor]
        (layer as! CAGradientLayer).locations = [0.0, 1.0]
        (layer as! CAGradientLayer).startPoint = CGPoint(x: 0.5, y: 0.25)
        (layer as! CAGradientLayer).endPoint = CGPoint(x: 0.5, y: 0.85)
    }
}
