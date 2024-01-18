//
//  SearchViewController + UICollectionView.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 28.12.2023.
//
import UIKit

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return presenter?.getUpcomingMovie().count ?? 0
        case 1:
//            print(" в UICollectionViewDataSource \(presenter?.getRecentMovie().first?.id)")
            return presenter?.getRecentMovie().count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
        case .upcomingMovies:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieCell.identifier, for: indexPath) as? UpcomingMovieCell else { return UICollectionViewCell() }
            
            guard let model = self.presenter?.getUpcomingMovie() else { return UICollectionViewCell() }
            cell.configure(with: model[indexPath.row])
            return cell
            
        case .recentMovies:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.identifier, for: indexPath) as? PopularCell else { return UICollectionViewCell() }
            
            guard let model = self.presenter?.getRecentMovie() else { return UICollectionViewCell() }
//            print(model)
            cell.configure(category: model[indexPath.row])
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchHeader.identifier,
                for: indexPath
            ) as? SearchHeader else { return UICollectionReusableView() }
            header.configure(header: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: -  UICollectionViewDelegate,
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionKind = SearchSection(rawValue: indexPath.section) else { return }
        
        switch sectionKind {
        case .upcomingMovies:
            presenter?.routeToDetail(with: indexPath.item)
        case .recentMovies:
            presenter?.routeToDetailFromRecent(with: indexPath.item)
        }
    }
}
