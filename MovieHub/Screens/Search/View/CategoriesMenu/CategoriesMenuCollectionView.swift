//
//  CategoriesMenuCollectionView.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 01.01.2024.
//

import UIKit

final class CategoriesMenuCollectionView: UICollectionView {
    
    private var categories: [CategoryModel]
    
    private let categoryLayout = UICollectionViewFlowLayout()
    
    init(categories: [CategoryModel]) {
        self.categories = categories
        super.init(frame: .zero, collectionViewLayout: categoryLayout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        categoryLayout.minimumInteritemSpacing = 5
        categoryLayout.scrollDirection = .horizontal
        
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        bounces = false
        showsHorizontalScrollIndicator = false
        
        delegate = self
        dataSource = self
        register(
            CategoriesMenuCell.self,
            forCellWithReuseIdentifier: CategoriesMenuCell.identifier
        )
        selectItem(at: [0,0], animated: true, scrollPosition: [])
    }
}

// MARK: - UICollectionViewDataSource
extension CategoriesMenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesMenuCell.identifier, for: indexPath) as? CategoriesMenuCell else { return UICollectionViewCell() }
        
        cell.categoryLabel.text = categories[indexPath.item].category.capitalized
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CategoriesMenuCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesMenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let categoryFont = UIFont.montserratMedium(size: 14)
        let categoryAttributes = [NSAttributedString.Key.font : categoryFont as Any]
        let categoryWidth = categories[indexPath.item].category.size(withAttributes: categoryAttributes).width + 20
        
        return CGSize(width: categoryWidth, height: collectionView.frame.height)
    }
}
