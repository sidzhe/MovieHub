//
//  HeaderCell.swift
//  MovieHub
//
//  Created by sidzhe on 27.12.2023.
//

import UIKit

final class HeaderCell: UICollectionReusableView {
    
    //MARK: Properties
    var callBackButton: (() -> Void)?
    
    //MARK: UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratBold(size: 14)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle(Constant.all, for: .normal)
        button.titleLabel?.font = UIFont.montserratRegular(size: 14)
        button.setTitleColor(.primaryBlue, for: .normal)
        button.addTarget(self, action: #selector(tapSee), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
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
    
    @objc private func tapSee() {
        callBackButton?()
    }
    
    func configure(header: String) {
        titleLabel.text = header
    }
}
