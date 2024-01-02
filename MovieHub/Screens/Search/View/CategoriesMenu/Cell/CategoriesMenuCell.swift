//
//  CategoriesMenuCell.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.12.2023.
//

import UIKit
import SnapKit

final class CategoriesMenuCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    //MARK: UI Elements
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.montserratMedium(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        backgroundColor = .primaryDark
        layer.cornerRadius = 8
        
        addSubview(categoryLabel)
    }
    
    private func setConstraints() {
        categoryLabel.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    func configure(category: CategoryModel) {
        categoryLabel.text = category.category.capitalized
        backgroundColor = category.isSelected ? .primarySoft : .clear
        categoryLabel.textColor = category.isSelected ? .primaryBlue : .white
    }
}

