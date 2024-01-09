//
//  SearchResultsViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 25.12.2023.
//

import UIKit

final class SearchResultsViewController: UIViewController {
    
    var searchedMovie: [Doc]?
    var searchedPerson: [DocPerson]?
    let sections = SearchResultSection.AllCases()
    
    // MARK: - UI
    private lazy var infoImageView: UIImageView = _infoImageView
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return collectionView
    }()
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegates()
        setConstraints()
        registerCollectionsCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(infoImageView)
        collectionView.backgroundColor = .primaryDark
    }
    
    // MARK: - Setup
    private func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCollectionsCells() {
        
        collectionView.register(
            PersonCell.self,
            forCellWithReuseIdentifier: PersonCell.identifier
        )
        
        collectionView.register(
            UpcomingMovieCell.self,
            forCellWithReuseIdentifier: UpcomingMovieCell.identifier
        )
        
        collectionView.register(
            SearchHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchHeader.identifier
        )
    }
    
    private func setConstraints() {
        infoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    //MARK: - Public Methods
    func updateSearchData(searchedMovie: [Doc]?, searchedPerson: [DocPerson]?) {
        self.searchedMovie = searchedMovie
        self.searchedPerson = searchedPerson
        Task {
            collectionView.reloadData()
        }
    }
    
    func updateInfoImageViewVisibility() {
        guard let searchedMovie = searchedMovie, let searchedPerson = searchedPerson else { return }
        if searchedMovie.isEmpty || searchedPerson.isEmpty {
            infoImageView.isHidden = false
        } else {
            infoImageView.isHidden = true
            Task { collectionView.reloadData() }
        }
    }
}
// MARK: - UICollectionViewCompositionalLayout
extension SearchResultsViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self  else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .person:
                return createPersonSection()
            case .movie:
                return createMoviesSection()
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
    
    private func createPersonSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .fractionalHeight(0.2)), 
            subitems: [item]
        )
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 20,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createMoviesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(200)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
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
    
    var _infoImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searchInfo")
        return imageView
    }
}
