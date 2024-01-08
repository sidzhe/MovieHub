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
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .primaryDark
        setDelegates()
        setConstraints()
        registerCollectionsCells()
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
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
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
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.3)), subitems: [item])
        
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 20,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createMoviesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
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
}