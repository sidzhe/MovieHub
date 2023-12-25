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
        
        view.backgroundColor = .black
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
        view.addSubview(collectionView)
    }
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 186),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - CompositionalLayout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                                  heightDimension: .fractionalWidth(0.2))
            let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .fractionalHeight(1))
            let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: layoutItem, count: 5)
            let sectionLayout = NSCollectionLayoutSection(group: layoutGroup)
            return sectionLayout
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: (view.frame.size.width / 3) - 5,
            height: (view.frame.size.height / 3) - 5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 23, bottom: 10, right: 20)
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
