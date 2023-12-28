//
//  HeaderCell.swift
//  MovieHub
//
//  Created by sidzhe on 27.12.2023.
//

import UIKit

final class HeaderCell: UICollectionReusableView {
    
    //MARK: UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratBold(size: 14)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle(button.isSelected ? "Hide" : "See All", for: .normal)
        button.titleLabel?.font = UIFont.montserratRegular(size: 14)
        button.setTitleColor(.primaryBlue, for: .normal)
        return button
    }()
    
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(button)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(header: String) {
        titleLabel.text = header
    }
}
