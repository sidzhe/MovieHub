//
//  BallView.swift
//  MovieHub
//
//  Created by sidzhe on 01.01.2024.
//

import UIKit
import SnapKit

final class BallView: UIView {
    
    //MARK: UI Elements
    private let ballImage = UIImageView()
    
    //MARK: Inits
    init(ballImage: UIImage?) {
        super.init(frame: .zero)
        self.ballImage.image = ballImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
