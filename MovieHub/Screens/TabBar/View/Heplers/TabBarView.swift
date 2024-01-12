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
        let icon = UIImageView()
        icon.tintColor = .primaryGray
        return icon
    }()
    
    private lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = UIFont.montserratMedium(size: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //MARK: Inits
    init(icon: UIImage, title: String, tag: Int) {
        super.init(frame: .zero)
        self.icon.image = icon
        self.iconLabel.text = title
        self.tag = tag
        self.updateLayout(state: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    //MARK: Methods
    func updateLayout(state: Bool) {
        if state {
            icon.tintColor = .primaryBlue
            iconLabel.textColor = .primaryBlue
            addSubview(icon)
            
            icon.snp.remakeConstraints { make in
                make.size.equalTo(24)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview()
            }
            
            iconLabel.snp.remakeConstraints { make in
                make.left.equalTo(icon.snp.right).offset(4)
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(4)
            }
        } else {
            icon.tintColor = .primaryGray
            iconLabel.textColor = .primaryGray
            iconLabel.removeFromSuperview()
            
            addSubview(icon)
            addSubview(iconLabel)
            
            icon.snp.remakeConstraints { make in
                make.size.equalTo(24)
                make.center.equalToSuperview()
            }
            
            iconLabel.snp.remakeConstraints { make in
                make.size.equalTo(0)
            }
        }
        
        self.layoutIfNeeded()
    }
}

