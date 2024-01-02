//
//  SearchHeader.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 02.01.2024.
//

import UIKit

final class SearchHeader: UICollectionReusableView {
    static let identifier = "SearchHeader"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratBold(size: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle(button.isSelected ? "Hide" : "See All", for: .normal)
        button.titleLabel?.font = UIFont.montserratRegular(size: 14)
        button.setTitleColor(.primaryBlue, for: .normal)
        button.addTarget(self, action: #selector(tapSeeAll), for: .touchUpInside)
        return button
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func setupViews() {
        addSubview(headerLabel)
        addSubview(seeAllButton)
    }
    
    private func setupLayout() {
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func tapSeeAll() {
       // callBackButton?()
    }
    
    func configure(header: String) {
        headerLabel.text = header
    }
}

