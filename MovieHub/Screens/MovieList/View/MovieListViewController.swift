//
//  MovieListViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    //MARK: Properties
    var presenter: MovieListPresenterProtocol?
    
    //MARK: UI Elements
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SectionMovie, ItemMovie>?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureCollectionView()
        createDataSource()
        applySnapshot()
        setCategories()
        
    }
    
    //MARK: - Display network error
    private func alertError(_ error: String) {
        let alert = UIAlertController(title: Constant.requestError, message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: SetupViews
    private func setupViews() {
        title = Constant.movieList
        view.backgroundColor = .primaryDark
        navigationController?.navigationBar.barTintColor = .primaryDark
    }
    
    //MARK: Setup Categories
    private func setCategories() {
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView(collectionView, didSelectItemAt: indexPath)
    }
}


//MARK: - Extension setup collectionView
private extension MovieListViewController {
    
    //MARK: Create Laouyt
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = SectionMovie(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .categories {
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(50), heightDimension: .absolute(31))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 8, leading: 16, bottom: 16, trailing: 16)
                
            } else if sectionKind == .movies {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.35))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                
            } else {
                fatalError(Constant.unknownSection)
            }
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    //MARK: Setup collection view
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView?.snp.makeConstraints({ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(90)
        })
    }
    
    //MARK: Regisration
    func registrationCategories() -> UICollectionView.CellRegistration<CategoriesCell, CategoryModel> {
        return UICollectionView.CellRegistration<CategoriesCell, CategoryModel> { cell, indexPath, categoriesModel in
            cell.configure(category: categoriesModel)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 8
        }
    }
    
    func registrationMovies() -> UICollectionView.CellRegistration<MovieListCell, Doc> {
        return UICollectionView.CellRegistration<MovieListCell, Doc> { cell, indexPath, movieModel in
            cell.configure(movieModel)
        }
    }
    
    //MARK: Create dataSource
    func createDataSource() {
        let registrationCategories = registrationCategories()
        let registrationMovies = registrationMovies()
        
        dataSource = UICollectionViewDiffableDataSource<SectionMovie, ItemMovie>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let sectionKind = SectionMovie(rawValue: indexPath.section) else { return nil }
            
            switch sectionKind {
            case .categories:
                return collectionView.dequeueConfiguredReusableCell(using: registrationCategories, for: indexPath, item: item.categories)
            case .movies:
                return collectionView.dequeueConfiguredReusableCell(using: registrationMovies, for: indexPath, item: item.movies)
            }
        }
    }
    
    //MARK: applySnapshot
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionMovie, ItemMovie>()
        
        guard let presenter = presenter else { return }
        
        snapshot.appendSections([.categories, .movies])
        let itemCategory = presenter.getCategories().map { ItemMovie(categories: $0)}
        let itemMovies = presenter.getMovies().map { ItemMovie(movies: $0)}
        snapshot.appendItems(itemCategory, toSection: .categories)
        snapshot.appendItems(itemMovies, toSection: .movies)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - Extension setup collectionView
extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let sectionKind = SectionMovie(rawValue: indexPath.section) else { return }
        
        switch sectionKind {
        case .categories:
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            let categoryElement = presenter?.getCategories()[indexPath.row].category ?? Constant.none
            presenter?.selectedCategory(indexPath.row, genre: MovieGenre(rawValue: categoryElement) ?? .all)
        default:
            presenter?.routeToDetail(index: indexPath.row)
        }
    }
}

//MARK: - Extension MovieListViewProtocol
extension MovieListViewController: MovieListViewProtocol {
    
    func updateUI() {
        Task { applySnapshot() }
    }
    
    func displayError(_ error: String) {
        Task { alertError(error) }
    }
}
