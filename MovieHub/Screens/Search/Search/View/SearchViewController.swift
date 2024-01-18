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
    
    var searchController: UISearchController!
    let sections = SearchSectionData.shared.sectionsArray
    var selectedCategory = Constant.biography
    var searchDelayTimer: Timer?
    let searchDelayInterval: TimeInterval = 2
    
    // MARK: - UI
    private lazy var categoriesMenuCollectionView: CategoriesMenuCollectionView = {
        let collectionView = CategoriesMenuCollectionView(categories: presenter?.getCategories() ?? [])
        return collectionView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        registerCollectionsCells()

        navigationController?.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchUpcomingMovie(with: selectedCategory)
        presenter?.fetchRecentMovie()
    }
    
    private func setupViews() {
        view.backgroundColor = .primaryDark
        
        setupSearchBar()
        view.addSubview(collectionView)
        view.addSubview(categoriesMenuCollectionView)
    }
    
    // MARK: - UISearchController
    private func setupSearchBar() {
        guard let navigationController else { return }
        searchController = UISearchController.makeCustomSearchController(
            navigationController: navigationController, placeholder: Constant.searchByActors,
            delegate: self, searchBarDelegate: self
        )
        navigationItem.searchController = searchController
    }
    
    //MARK: - Display network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: Constant.requestError, message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // MARK: - Setup
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCollectionsCells() {
        collectionView.register(
            UpcomingMovieCell.self,
            forCellWithReuseIdentifier: UpcomingMovieCell.identifier
        )
        
        collectionView.register(
            PopularCell.self,
            forCellWithReuseIdentifier: PopularCell.identifier
        )
        
        collectionView.register(
            SearchHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchHeader.identifier)
    }
    
    private func setConstraints() {
        
        categoriesMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view.snp.leading).offset(14)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(31)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesMenuCollectionView.snp.bottom).offset(5)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}
//MARK: - Extension SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    
    func displayRequestError(error: RequestError) {
        Task {
            alertError(_:error)
        }
    }
    
    func updateUI() {
        Task {
            collectionView.reloadData()
        }
    }
    // MARK: - Gesture Handler
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            searchController.isActive = false
        }
    }
}

//MARK: - Create CompositionalLayout
extension SearchViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self  else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .upcomingMovies:
                return self.createUpcomingMoviesSection()
            case .recentMovies:
                return self.createRecentMoviesSection()
            }
        }
    }
    
    private func createLayoutSection(
        group: NSCollectionLayoutGroup,
        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
        contentInsets: Bool) -> NSCollectionLayoutSection {
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = behavior
            section.interGroupSpacing = interGroupSpacing
            section.boundarySupplementaryItems = supplementaryItems
            section.supplementariesFollowContentInsets = contentInsets
            return section
        }
    
    private func createUpcomingMoviesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.87),
            heightDimension: .fractionalHeight(0.33)),
            subitems: [item]
        )
        
        let section = createLayoutSection(group: group,
                                          behavior: .paging,
                                          interGroupSpacing: 8,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 0)
        
        return section
    }
    
    private func createRecentMoviesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension:  .fractionalWidth(0.35),
                heightDimension: .fractionalHeight(0.38)
            ),
            subitems: [item]
        )
        
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpacing: 10,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false
        )
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 0)
        return section
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .estimated(50)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top
        )
    }
}

//MARK: - Constants
extension SearchViewController {
    struct Constants {
        static let topAnchor: CGFloat = 8
        static let horizontalSpacing: CGFloat = 20
        static let interItemSpacing: CGFloat = 20
    }
}
