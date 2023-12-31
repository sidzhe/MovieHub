//
//  SearchviewController + UICollectionView.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 28.12.2023.
//
import UIKit

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCategories().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesSearchCell.identifier, for: indexPath) as? CategoriesSearchCell else {
            return UICollectionViewCell()
        }
        
        guard let model = self.presenter?.getCategories() else { return cell }
        cell.configure(category: model[indexPath.row])
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 8
        
        return cell
    }
}

// MARK: -  UICollectionViewDelegate,
extension SearchViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let sectionKind = presenter?.searchSections[indexPath.section]
        
        switch sectionKind {
        case .categories:
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            let value = presenter?.getCategories()[indexPath.row].category ?? ""
            presenter?.selectedCategory(indexPath.row, genre: MovieGenre(rawValue: value)!)
        default:
           break
        }
    }
}
