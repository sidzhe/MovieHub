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
    init(ballImage: String) {
        super.init(frame: .zero)
        self.ballImage.image = UIImage(named: ballImage)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    //MARK: SetupView
    private func setupViews() {
        isUserInteractionEnabled = true
        addSubview(ballImage)
        ballImage.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    //MARK: Update ball image
    func updateImage(_ imageName: String) {
        ballImage.image = UIImage(named: imageName)
    }
}
