//
//  SearchViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    enum Section {
        case category
        case upcomingMovie
        case recentMovie
    }
    
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
        navigationController?.setupNavigationBar()
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
       
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "YourCellReuseIdentifier")
        collectionView.register(RecentMovieCollectionViewCell.self, forCellWithReuseIdentifier: RecentMovieCollectionViewCell.identifier )
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
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(0.1))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: .absolute(20))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [layoutItem])
            let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
            layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return layoutSection
        }
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count >= 2 else { return }
        
        if let resultController = searchController.searchResultsController as? SearchResultsViewController {
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
