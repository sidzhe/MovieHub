//
//  MainViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: Properties
    var presenter: MainPresenterProtocol?
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ItemMain>?
    
    //MARK: UI Elements
    private let accountView = AccountView()
    
    private lazy var seatchTextField: UISearchTextField = {
        let text = UISearchTextField()
        text.backgroundColor = .primarySoft
        text.clipsToBounds = true
        text.layer.cornerRadius = 24
        text.clearButtonMode = .always
        text.textColor = .primaryGray
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.primaryGray, .font: UIFont.montserratMedium(size: 15)!]
        text.attributedPlaceholder = NSAttributedString(string: "Search a title..", attributes: placeholderAttributes)
        text.leftView?.tintColor = .primaryGray
        if let clearButton = text.value(forKey: "clearButton") as? UIButton {
            clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.tintColor = .primaryBlue
        }
        text.delegate = self
        return text
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetch()
        setupView()
        configureCollectionView()
        createDataSource()
        applySnapshot()
        setCategories()
        heartButtonTarget()
        
    }
    
    //MARK: Set Views
    private func setupView() {
        view.backgroundColor = .primaryDark
        view.addSubview(accountView)
        view.addSubview(seatchTextField)
        
        accountView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
        
        seatchTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(25)
            make.top.equalTo(accountView.snp.bottom).offset(15)
            make.height.equalTo(48)
        }
    }
    
    //MARK: Set Categories
    private func setCategories() {
        let indexPath = IndexPath(row: 0, section: 2)
        collectionView(collectionView, didSelectItemAt: indexPath)
    }
    
    //MARK: Target
    private func heartButtonTarget() {
        accountView.callBackButton = { [weak self] in self?.presenter?.routeToWishList() }
    }
    
    //MARK: - Display network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: "Request error", message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        Task { present(alert, animated: true) }
    }
}


//MARK: - Extension Set CollactionView
private extension MainViewController {
    
    //MARK: Create Laouyt
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .search {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 10, bottom: 15, trailing: 10)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.65))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 0)
                
            } else if sectionKind == .collection {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.35))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 0)
                
            } else if sectionKind == .categories {
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(115), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(115), heightDimension: .absolute(31))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .popular {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.65))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else {
                fatalError("Unkown section")
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
            make.top.equalTo(seatchTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        })
    }
    
    //MARK: Regisration
    func registrationSearch() -> UICollectionView.CellRegistration<PopularCell, Doc> {
        return UICollectionView.CellRegistration<PopularCell, Doc> { [weak self] cell, indexPath, itemIdentifier in
            guard let model = self?.presenter?.getSearchData() else { return }
            cell.configure(category: model[indexPath.row])
        }
    }
    
    func registrationCollection() -> UICollectionView.CellRegistration<CollectionCell, DocCollect> {
        return UICollectionView.CellRegistration<CollectionCell, DocCollect> { [weak self] cell, indexPath, itemIdentifier in
            guard let model = self?.presenter?.getColletionModel() else { return }
            cell.configure(model[indexPath.row])
        }
    }
    
    func registrationCategories() -> UICollectionView.CellRegistration<CategoriesCell, CategoryModel> {
        return UICollectionView.CellRegistration<CategoriesCell, CategoryModel> { [weak self] cell, indexPath, itemIdentifier in
            guard let model = self?.presenter?.getCategories() else { return }
            cell.configure(category: model[indexPath.row])
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 8
        }
    }
    
    func registrationMostPopular() -> UICollectionView.CellRegistration<PopularCell, Doc> {
        return UICollectionView.CellRegistration<PopularCell, Doc> { [weak self] cell, indexPath, itemIdentifier in
            guard let model = self?.presenter?.getMostPopular() else { return }
            cell.configure(category: model[indexPath.row])
        }
    }
    
    func registrationCagegoryHeader() -> UICollectionView.SupplementaryRegistration<HeaderCell> {
        return UICollectionView.SupplementaryRegistration<HeaderCell> (elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.callBackButton = { [weak self] in self?.presenter?.routeToMovieList() }
            header.configure(header: "Categories")
        }
    }
    
    func registrationPopularHeader() -> UICollectionView.SupplementaryRegistration<HeaderCell> {
        return UICollectionView.SupplementaryRegistration<HeaderCell> (elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.callBackButton = { [weak self] in self?.presenter?.routeToPupularMovie() }
            header.configure(header: "Most popular")
        }
    }
    
    //MARK: Create dataSource
    func createDataSource() {
        let registrationSearch = registrationSearch()
        let registrationCollection = registrationCollection()
        let registrationCategories = registrationCategories()
        let registrationMostPopular = registrationMostPopular()
        let registrationCategoryHeader = registrationCagegoryHeader()
        let registrationPopularHeader = registrationPopularHeader()
        
        dataSource = UICollectionViewDiffableDataSource<Section, ItemMain>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let sectionKind = Section(rawValue: indexPath.section) else { return nil }
            
            switch sectionKind {
            case .search:
                return collectionView.dequeueConfiguredReusableCell(using: registrationSearch, for: indexPath, item: item.search)
            case .collection:
                return collectionView.dequeueConfiguredReusableCell(using: registrationCollection, for: indexPath, item: item.collection)
            case .categories:
                return collectionView.dequeueConfiguredReusableCell(using: registrationCategories, for: indexPath, item: item.categories)
            case .popular:
                return collectionView.dequeueConfiguredReusableCell(using: registrationMostPopular, for: indexPath, item: item.popular)
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = Section(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .search:
                        return nil
                    case .collection:
                        return nil
                    case .categories:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: registrationCategoryHeader, for: indexPath)
                    case .popular:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: registrationPopularHeader, for: indexPath)
                    }
                }
            }
            return nil
        }
    }
    
    //MARK: applySnapshot
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemMain>()
        
        guard let presenter = presenter else { return }
        
        if presenter.getSearchData().isEmpty {
            snapshot.appendSections([.search, .collection, .categories, .popular])
            let itemSearch = presenter.getSearchData().map { ItemMain(search: $0)}
            let itemCollection = presenter.getColletionModel().map { ItemMain(collection: $0)}
            let itemCategory = presenter.getCategories().map { ItemMain(categories: $0)}
            let itemPopular = presenter.getMostPopular().map { ItemMain(popular: $0)}
            
            snapshot.appendItems(itemSearch, toSection: .search)
            snapshot.appendItems(itemCollection, toSection: .collection)
            snapshot.appendItems(itemCategory, toSection: .categories)
            snapshot.appendItems(itemPopular, toSection: .popular)
        } else {
            snapshot.appendSections([.search])
            let itemSearch = presenter.getSearchData().map { ItemMain(search: $0)}
            snapshot.appendItems(itemSearch, toSection: .search)
        }
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - Extension UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let sectionKind = Section(rawValue: indexPath.section) else { return }
        
        switch sectionKind {
        case .categories:
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            let value = presenter?.getCategories()[indexPath.row].category ?? ""
            presenter?.selectedCategory(indexPath.row, genre: MovieGenre(rawValue: value)!)
        default:
            presenter?.routeToDetail()
        }
    }
}


//MARK: - Extension MainViewProtocol
extension MainViewController: MainViewProtocol {
    func updateUI() {
        Task { applySnapshot() }
    }
    
    func displayRequestError(error: RequestError) {
        alertError(error)
    }
}


//MARK: - Extension UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        presenter?.fetchSearchRequest(text)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        presenter?.fetchSearchRequest("")
        return true
    }
}
