//
//  PersonHeader.swift
//  MovieHub
//
//  Created by sidzhe on 04.01.2024.
//

import UIKit

final class PersonHeader: UICollectionReusableView {
    
    //MARK: UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratBold(size: 14)
        return label
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup UI
    private func setupViews() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
    }
    
    //MARK: Configure
    func configure(header: String) {
        titleLabel.text = header
    }
}
