//
//  TabBarView.swift
//  MovieHub
//
//  Created by sidzhe on 30.12.2023.
//

import UIKit
import SnapKit

final class TabBarView: UIView {
    
    //MARK: UI elements
    private lazy var icon: UIImageView = {
        let button = UIImageView()
        button.tintColor = .primaryBlue
        return button
    }()
    
    private lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryBlue
        label.font = UIFont.montserratMedium(size: 12)
        return label
    }()
    
    //MARK: Inits
    init(icon: UIImage, title: String, tag: Int) {
        super.init(frame: .zero)
        self.icon.image = icon
        self.iconLabel.text = title
        self.tag = tag
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func setupViews() {
        addSubview(icon)
        
        icon.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

