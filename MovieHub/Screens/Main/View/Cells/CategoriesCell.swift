//
//  CategoriesCell.swift
//  MovieHub
//
//  Created by sidzhe on 27.12.2023.
//

import UIKit

final class CategoriesCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.montserratMedium(size: 12)
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
    
    //MARK: - Methods
    private func setupViews() {
        contentView.addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
    }
    
    func configure(category: CategoryModel) {
        categoryLabel.text = category.category.capitalized
        backgroundColor = category.isSelected ? .primarySoft : .clear
        categoryLabel.textColor = category.isSelected ? .primaryBlue : .white
    }
}
