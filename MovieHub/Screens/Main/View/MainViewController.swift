//
//  MainViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit
import CoreLocation

final class MainViewController: UIViewController {
    
    //MARK: Properties
    var presenter: MainPresenterProtocol?
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ItemMain>?
    private let coreLocation = CLLocationManager()
    
    //MARK: UI Elements
    private let accountView = AccountView()
    
    private lazy var seatchTextField: UISearchTextField = {
        let text = UISearchTextField()
        text.backgroundColor = .primarySoft
        text.clipsToBounds = true
        text.layer.cornerRadius = 24
        text.clearButtonMode = .always
        text.font = UIFont.montserratMedium(size: 15)
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
        
        setupView()
        configureCollectionView()
        createDataSource()
        applySnapshot()
        setCategories()
        accountViewButtonsTarget()
        setLocation()
        
    }
    
    //MARK: Setup Views
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
    
    //MARK: Setup user location
    private func setLocation() {
        coreLocation.delegate = self
        coreLocation.desiredAccuracy = .leastNormalMagnitude
        coreLocation.requestWhenInUseAuthorization()
        coreLocation.startUpdatingLocation()
    }
    
    //MARK: Setup Categories
    private func setCategories() {
        let indexPath = IndexPath(row: 0, section: 2)
        collectionView(collectionView, didSelectItemAt: indexPath)
        presenter?.fetch()
    }
    
    //MARK: Target
    private func accountViewButtonsTarget() {
        accountView.callBackButton = { [weak self] in self?.presenter?.routeToWishList() }
        accountView.callBackGlobe = { [weak self] in self?.presenter?.routeToGlobe() }
    }
    
    //MARK: - Display network error
    private func alertError(_ error: String) {
        let alert = UIAlertController(title: "Request error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
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
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.6))
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
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .estimated(31))
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
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.5))
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
            make.bottom.equalToSuperview().inset(90)
        })
    }
    
    //MARK: Regisration
    func registrationSearch() -> UICollectionView.CellRegistration<PopularCell, Doc> {
        return UICollectionView.CellRegistration<PopularCell, Doc> { cell, indexPath, searchModel in
            cell.configure(category: searchModel)
        }
    }
    
    func registrationCollection() -> UICollectionView.CellRegistration<CollectionCell, DocCollect> {
        return UICollectionView.CellRegistration<CollectionCell, DocCollect> { cell, indexPath, collectionItem in
            cell.configure(collectionItem)
        }
    }
    
    func registrationCategories() -> UICollectionView.CellRegistration<CategoriesCell, CategoryModel> {
        return UICollectionView.CellRegistration<CategoriesCell, CategoryModel> { cell, indexPath, categoriesModel in
            cell.configure(category: categoriesModel)
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 8
        }
    }
    
    func registrationMostPopular() -> UICollectionView.CellRegistration<PopularCell, Doc> {
        return UICollectionView.CellRegistration<PopularCell, Doc> { cell, indexPath, popularModel in
            cell.configure(category: popularModel)
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
        
        collectionView.performBatchUpdates {
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
        
    }
}

//MARK: - Extension UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        guard let sectionKind = Section(rawValue: indexPath.section) else { return }
        
        switch sectionKind {
        case .categories:
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
    
    func displayRequestError(error: String) {
        Task { alertError(error) }
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


//MARK: - Extension CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    
    //MARK: Get current city name from location
    private func makeGeoDecoderLocation(_ location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "ru")
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: locale) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.alertError("Ошибка обратного геокодирования: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                self.alertError("Город не найден")
                return
            }
            
            if let city = placemark.locality {
                completion(city)
            } else {
                self.alertError("Город не найден в ответе геокодирования.")
            }
        }
    }
    
    
    //MARK: Location default methoods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        coreLocation.startUpdatingLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        var currentCity = ""
        makeGeoDecoderLocation(location) { [weak self] in
            currentCity = $0
            self?.presenter?.sendMyLocation(lat: lat, lon: lon, cityName: currentCity)
            self?.coreLocation.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        alertError("Ошибка получения текущей локации \(error.localizedDescription)")
    }
}
