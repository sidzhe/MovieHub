//
//  GlobeViewController.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import UIKit

final class GlobeViewController: UIViewController {
    
    //MARK: Properties
    var presenter: GlobePresenterProtocol?
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, GlobeItem>?
    
    //MARK: UI Element
    private lazy var seatchTextField: UISearchTextField = {
        let text = UISearchTextField()
        text.backgroundColor = .primarySoft
        text.clipsToBounds = true
        text.layer.cornerRadius = 5
        text.clearButtonMode = .always
        text.font = UIFont.montserratMedium(size: 15)
        text.textColor = .white
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.primaryGray, .font: UIFont.montserratMedium(size: 15)!]
        text.attributedPlaceholder = NSAttributedString(string: "Кинотеатр, улица", attributes: placeholderAttributes)
        text.leftView?.tintColor = .primaryGray
        if let clearButton = text.value(forKey: "clearButton") as? UIButton {
            clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.tintColor = .primaryBlue
        }
        text.delegate = self
        text.frame = CGRect(x: 0, y: 0, width: view.frame.width + 10, height: 44)
        return text
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureDataSource()
        applyInitialSnapshots()
        
    }
    
    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        seatchTextField.text = nil
        presenter?.loadCurrentCity()
        
    }
    
    //MARK: - Display network error
    private func alertError(_ error: String) {
        let alert = UIAlertController(title: "Request error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: - Search text filter
    private func performQuery(with filter: String?) {
        let text = presenter?.filteredText(with: filter)
        let firstSectionItem = GlobeItem(city: "")
        let secondSectionItem = GlobeItem(city: "")
        let cinemaItem = text?.compactMap { GlobeItem(cinema: $0) } ?? [GlobeItem()]
        var snapshot = NSDiffableDataSourceSnapshot<Int, GlobeItem>()
       
        snapshot.appendSections([0, 1, 2])
        snapshot.appendItems([firstSectionItem], toSection: 0)
        snapshot.appendItems([secondSectionItem], toSection: 1)
        snapshot.appendItems(cinemaItem, toSection: 2)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - Extension GlobeViewController
private extension GlobeViewController {
    
    //MARK: - UI
    private func setupUI() {
        view.backgroundColor = .primaryDark
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        view.addSubview(seatchTextField)
        view.addSubview(collectionView)
        
        seatchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(seatchTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(90)
        }
    }
    
    //MARK: - Layout
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            switch sectionIndex {
            case 0:
                let spacing = CGFloat(0)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(45))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(spacing)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = spacing
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                return section
                
            case 1:
                let spacing = CGFloat(0)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(46))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(spacing)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = spacing
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                return section
                
            case 2:
                let spacing = CGFloat(20)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(spacing)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = spacing
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                return section
                
            default:
                return nil
            }
        }
        
        return layout
    }
    
    private func configureDataSource() {
        let cellCityRegistration = UICollectionView.CellRegistration<GlobeCustomCell, GlobeItem> { [weak self] (cell, indexPath, item) in
            guard let city = self?.presenter?.getCurrentCity() else { return }
            cell.configure(nameLabel: "Город", city: city, imageName: "mappin.circle")
        }
        
        let cellMapRegistration = UICollectionView.CellRegistration<GlobeCustomCell, GlobeItem> { (cell, indexPath, item) in
            cell.configure(nameLabel: "Кинотеатры на карте", city: "", imageName: "map.circle")
        }
        
        let cellRegistration = UICollectionView.CellRegistration<CinemaCell, GlobeItem> { (cell, indexPath, item) in
            guard let cinema = item.cinema else { return }
            cell.configure(model: cinema)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, GlobeItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item) -> UICollectionViewCell? in
            
            switch indexPath.section {
            case 0:
                return collectionView.dequeueConfiguredReusableCell(using: cellCityRegistration, for: indexPath, item: item)
            case 1:
                return collectionView.dequeueConfiguredReusableCell(using: cellMapRegistration, for: indexPath, item: item)
            case 2:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
            default:
                return nil
            }
        }
    }
    
    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, GlobeItem>()
        snapshot.appendSections([0, 1, 2])
        let firstSectionItem = GlobeItem(city: "")
        let secondSectionItem = GlobeItem(city: "")
        let cinemaItem = presenter?.getCinemaData().compactMap { GlobeItem(cinema: $0) } ?? [GlobeItem()]
        snapshot.appendItems([firstSectionItem], toSection: 0)
        snapshot.appendItems([secondSectionItem], toSection: 1)
        snapshot.appendItems(cinemaItem, toSection: 2)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - Extension UICollectionViewDelegate
extension GlobeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            presenter?.routeToCityList()
        case 1:
            presenter?.routeToMap()
        case 2:
            presenter?.routeToCinemaDetail(index: indexPath.row)
        default:
            break
        }
    }
}


//MARK: - Extension UITextFieldDelegate
extension GlobeViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        performQuery(with: textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

//MARK: - Extension MovieListViewProtocol
extension GlobeViewController: GlobeViewProtocol {
    
    func updateUI() {
        Task { applyInitialSnapshots() }
    }
    
    func displayErrorMessage(_ message: String) {
        Task { alertError(message) }
    }
}
