//
//  SearchResultController+.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 07.01.2024.
//
import UIKit

extension SearchResultsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return searchedPerson?.count ?? 0
        case 2:
            return searchedMovie?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
            
        case .person:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCell.identifier, for: indexPath) as? PersonCell
            else {
                return UICollectionViewCell()
            }
            
            guard let person = searchedPerson?[indexPath.row] else { return cell }
            cell.configure(person: person)
            return cell
            
        case .movie:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieCell.identifier, for: indexPath) as? UpcomingMovieCell
            else {
                return UICollectionViewCell()
            }
            
            guard let searchData = searchedMovie?[indexPath.row] else { return cell }
            cell.configure(for: searchData)
            return cell
        }
    }
}

extension SearchResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

