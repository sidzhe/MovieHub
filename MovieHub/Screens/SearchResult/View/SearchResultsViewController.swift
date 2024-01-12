//
//  SearchResultsViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 25.12.2023.
//

import UIKit

final class SearchResultsViewController: UIViewController {
    
    let sections = SearchResultSectionData.shared.sectionsArray
    
    var presenter: SearchResultPresenterProtocol?
    var parentNavigationController: UINavigationController?
    
    // MARK: - UI
    private lazy var infoImageView: UIImageView = _infoImageView
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return collectionView
    }()
    
    init(navigationController: UINavigationController) {
           self.parentNavigationController = navigationController
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setDelegates()
        setConstraints()
        registerCollectionsCells()
        collectionView.isHidden = true
    }
    
    // MARK: - Private methods
    private func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(infoImageView)
        collectionView.backgroundColor = .primaryDark
    }
    
    
    //MARK: - Display network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: "Request error", message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
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
}

// MARK: - UICollectionViewCompositionalLayout
extension SearchResultsViewController {
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            
            switch section {
            case .person:
                if self.presenter?.getSearchPerson().isEmpty == true {
                    return nil
                } else {
                    return self.createPersonSection()
                }
            case .movie:
                if self.presenter?.getSearchMovie().isEmpty == true {
                    return nil
                } else {
                    return self.createMoviesSection()
                }
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
            widthDimension: .fractionalWidth(0.35),
            heightDimension: .fractionalHeight(0.2)),
                                                       subitems: [item]
        )
        
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 20)
        
        return section
    }
    
    private func createMoviesSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(0.25)),
                                                     subitems: [item]
        )
        
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 16,
                                          supplementaryItems: [supplementaryHeaderItem()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
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

extension SearchResultsViewController: SearchResultViewProtocol {
    func displayRequestError(error: RequestError) {
        Task {
            alertError(_:error)
        }
    }
    
    func updateUI() {
        let isSearchMovieEmpty = presenter?.getSearchMovie().isEmpty ?? true
        let isSearchPersonEmpty = presenter?.getSearchPerson().isEmpty ?? true
        
        
        DispatchQueue.main.async { [weak self] in
            self?.infoImageView.isHidden = !isSearchMovieEmpty || !isSearchPersonEmpty
            self?.collectionView.isHidden = isSearchMovieEmpty && isSearchPersonEmpty
            self?.collectionView.reloadData()
        }
    }
}

extension SearchResultsViewController {
    var _infoImageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "searchInfo")
        imageView.isHidden = true
        return imageView
    }
}
