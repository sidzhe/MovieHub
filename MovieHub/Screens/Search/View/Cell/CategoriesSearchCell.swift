//
//  CategoriesSearchCell.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.12.2023.
//

import UIKit

final class CategoriesSearchCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    //MARK: UI Elements
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.montserratMedium(size: 12)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 20
        view.backgroundColor = .clear
        return view
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
        stackView.addArrangedSubview(categoryLabel)
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        
        categoryLabel.snp.makeConstraints { $0.center.equalToSuperview() }
    }
    
    func configure(category: SearchCategoryModel) {
        categoryLabel.text = category.category.capitalized
        backgroundColor = category.isSelected ? .primarySoft : .clear
        categoryLabel.textColor = category.isSelected ? .primaryBlue : .white
    }
}

