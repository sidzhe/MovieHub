//
//  SearchHeader.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 02.01.2024.
//

import UIKit

final class SearchHeader: UICollectionReusableView {
    static let identifier = Constant.searchHeader
    
    var callBackAllButton: (() -> Void)?
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratBold(size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle(button.isSelected ? Constant.hide : Constant.none, for: .normal)
        button.titleLabel?.font = UIFont.montserratRegular(size: 14)
        button.setTitleColor(.primaryBlue, for: .normal)
        button.addTarget(self, action: #selector(tapSeeAll), for: .touchUpInside)
        return button
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    //MARK: Methods
    private func setupViews() {
        addSubview(headerLabel)
        addSubview(seeAllButton)
    }
    
    private func setConstraints() {
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
        callBackAllButton?()
    }
    
    func configure(header: String) {
        headerLabel.text = header
    }
}

