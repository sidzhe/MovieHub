//
//  CategoriesMenuCollectionView.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 01.01.2024.
//

import UIKit

final class CategoriesMenuCollectionView: UICollectionView {
    
    private var categories: [CategoryModel]
    
    private let categoryLayout = UICollectionViewLayout()
    
    init(categories: [CategoryModel]) {
        self.categories = categories
        super.init(frame: .zero, collectionViewLayout: categoryLayout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        dataSource = self
        register(
            CategoriesMenuCell.self,
            forCellWithReuseIdentifier: CategoriesMenuCell.identifier
        )
    }
}

// MARK: - UICollectionViewDataSource
extension CategoriesMenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesMenuCell.identifier, for: indexPath) as? CategoriesMenuCell else { return UICollectionViewCell() }
        cell.configure(category: categories[indexPath.row])
        return cell
    }
}

extension CategoriesMenuCollectionView: UICollectionViewDelegate {
    
}
