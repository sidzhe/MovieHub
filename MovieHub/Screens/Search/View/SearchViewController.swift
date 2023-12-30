//
//  SearchViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    //MARK: Properties
    var presenter: SearchPresenterProtocol?
    
    // MARK: - Outlets
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryDark
        setupSearchBar()
        registerCollectionsCells()
        setupHierarchy()
        setupLayout()
        setCategories()
        navigationController?.setupNavigationBar()
    }
    
    //MARK: Set Categories
    private func setCategories() {
        let indexPath = IndexPath(row: 0, section: 2)
        collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    // MARK: - UISearchController
    private func setupSearchBar() {
        
        let searchController = UISearchController.makeCustomSearchController(
            placeholder: "Type title, categories, years, etc",
            delegate: self
        )
        navigationItem.searchController = searchController
    }
    
    // MARK: - Setup
    
    private func registerCollectionsCells() {
        collectionView.register(CategoriesSearchCell.self, forCellWithReuseIdentifier: CategoriesSearchCell.identifier)
     //   collectionView.register(RecentMovieCollectionViewCell.self, forCellWithReuseIdentifier: RecentMovieCollectionViewCell.identifier )
    }
    
    private func setupHierarchy() {
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
    }
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 144),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - CompositionalLayout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets.trailing = 16
            layoutItem.contentInsets.bottom = 16
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.35),
                heightDimension: .absolute(35))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])
            
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.interGroupSpacing = 15
            layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 15, trailing: 0)
            
            return layoutSection
            
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count >= 2 else { return }
        
        if searchController.searchResultsController is SearchResultsViewController {
            //
            //            resultController.navigationControllerFromCategories = self.navigationController
            //            resultController.viewModel.searchText = searchText
        }
    }
}



//MARK: - Extension SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    
}

//MARK: Constants
extension SearchViewController{
    struct Constants {
        static let topAnchor: CGFloat = 8
        static let horizontalSpacing: CGFloat = 20
        static let interItemSpacing: CGFloat = 20
    }
}
