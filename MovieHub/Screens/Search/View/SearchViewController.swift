//
//  SearchViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    //MARK: Properties
    var presenter: SearchPresenterProtocol?
    
    // MARK: - Outlets
    private lazy var categoriesMenuCollectionView: CategoriesMenuCollectionView = {
        let collectionView = CategoriesMenuCollectionView(categories: presenter?.getCategories() ?? [])

        return collectionView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupSearchBar()
        setupViews()
        setupLayout()
        registerCollectionsCells()
        //        setDelegates()
       
        
        navigationController?.setupNavigationBar()
    }
    
    private func setupViews() {
        view.backgroundColor = .primaryDark
        view.addSubview(categoriesMenuCollectionView)
        view.addSubview(collectionView)
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
    //    private func setDelegates() {
    //        collectionView.delegate = self
    //        collectionView.dataSource = self
    //    }
    
    private func registerCollectionsCells() {
        
        collectionView.register(
            UpcomingMovieCell.self,
            forCellWithReuseIdentifier: UpcomingMovieCell.identifier
        )
        
        collectionView.register(
            RecentMovieCollectionViewCell.self,
            forCellWithReuseIdentifier: RecentMovieCollectionViewCell.identifier
        )
    }
    
    private func setupLayout() {
        
        categoriesMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(31)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesMenuCollectionView.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            
        }
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
    func updateUI() {
        categoriesMenuCollectionView.reloadData()
    }
    
    
}

//MARK: Constants
extension SearchViewController{
    struct Constants {
        static let topAnchor: CGFloat = 8
        static let horizontalSpacing: CGFloat = 20
        static let interItemSpacing: CGFloat = 20
    }
}
