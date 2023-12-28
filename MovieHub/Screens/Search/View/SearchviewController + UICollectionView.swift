//
//  SearchviewController + UICollectionView.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 28.12.2023.
//
import UIKit

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourCellReuseIdentifier", for: indexPath)
        cell.backgroundColor = UIColor.green
        
        cell.frame.size = CGSize(width: 355, height: 147)
        
        return cell
    }
}
