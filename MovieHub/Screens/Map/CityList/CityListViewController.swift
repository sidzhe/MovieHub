//
//  CityListViewController.swift
//  MovieHub
//
//  Created by sidzhe on 07.01.2024.
//

import UIKit

final class CityListViewController: UIViewController {
    
    //MARK: Properties
    var presenter: CityListPresenterProtocol?
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>?
    
    //MARK: - UI Elements
    private lazy var seatchTextField: UISearchTextField = {
        let text = UISearchTextField()
        text.backgroundColor = .primarySoft
        text.clipsToBounds = true
        text.layer.cornerRadius = 5
        text.clearButtonMode = .always
        text.font = UIFont.montserratMedium(size: 15)
        text.textColor = .white
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.primaryGray, .font: UIFont.montserratMedium(size: 15)!]
        text.attributedPlaceholder = NSAttributedString(string: Constant.whereAreYou, attributes: placeholderAttributes)
        text.leftView?.tintColor = .primaryGray
        if let clearButton = text.value(forKey: Constant.keyClearButton) as? UIButton {
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
        
        setupViews()
        configureDataSource()
        applyInitialSnapshots()
        
    }
    
    //MARK: - City filter
    private func performQuery(with filter: String?) {
        guard let presenter = presenter else { return }
        let text = presenter.filteredCity(with: filter)
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([.min])
        snapshot.appendItems(text)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - Extension CityListViewController
private extension CityListViewController {
    
    //MARK: Create layout
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let spacing = CGFloat(20)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(spacing)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
        
        return layout
    }
    
    //MARK: Setup UI
    func setupViews() {
        title = Constant.selectCity
        view.backgroundColor = .primaryDark
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        view.addSubview(seatchTextField)
        view.addSubview(collectionView)
        
        seatchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(seatchTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { (cell, indexPath, city) in
            var content = cell.defaultContentConfiguration()
            var backgroundContent = UIBackgroundConfiguration.listGroupedCell()
            backgroundContent.backgroundColor = .primarySoft
            cell.backgroundConfiguration = backgroundContent
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 5
            content.text = city
            content.textProperties.alignment = .justified
            content.textProperties.font = UIFont.montserratMedium(size: 14) ?? .boldSystemFont(ofSize: 14)
            content.textProperties.color = .white
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, string: String) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: string)
        }
    }
    
    private func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        guard let presenter = presenter else { return }
        snapshot.appendSections([.zero])
        snapshot.appendItems(presenter.getCityList())
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - UISearchBarDelegate
extension CityListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let searchText = seatchTextField.text, let presenter = presenter else { return }
        
        if searchText.isEmpty {
            let city = presenter.getCityList()[indexPath.row]
            presenter.saveSelectedCity(name: city)
        } else {
            let city = presenter.getFilteredCity()[indexPath.row]
            presenter.saveSelectedCity(name: city)
        }
        
        presenter.routeToPrevious()
    }
}

//MARK: - UISearchBarDelegate
extension CityListViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        performQuery(with: textField.text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

//MARK: - Extension MovieListViewProtocol
extension CityListViewController: CityListViewProtocol {
    
}
