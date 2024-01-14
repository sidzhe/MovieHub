//
//  TrailerHeader.swift
//  MovieHub
//
//  Created by sidzhe on 13.01.2024.
//

import UIKit
import SnapKit
 
final class TrailerHeader: UICollectionReusableView {
    
    //MARK: UI Elements
    private lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratBold(size: 16)
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
        addSubviews(header)
        
        header.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
    }
    
    //MARK: Configure
    func configure(_ title: String) {
        header.text = title
    }
}
