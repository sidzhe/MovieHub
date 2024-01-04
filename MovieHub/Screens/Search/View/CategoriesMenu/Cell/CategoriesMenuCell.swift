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
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.montserratMedium(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .primarySoft : .clear
            categoryLabel.textColor = isSelected ? .primaryBlue : .white
        }
    }
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func configure(category: MovieGenre) {
        categoryLabel.text = category.rawValue.capitalized
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        backgroundColor = .primaryDark
        layer.cornerRadius = 8
        
        addSubview(categoryLabel)
    }
    
    private func setConstraints() {
        categoryLabel.snp.makeConstraints { $0.center.equalToSuperview() }
    }
}

