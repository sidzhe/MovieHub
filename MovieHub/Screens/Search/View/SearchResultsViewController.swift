//
//  SearchResultsViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 25.12.2023.
//

import UIKit

final class SearchResultsViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(UpcomingMovieCell.self, forCellWithReuseIdentifier: UpcomingMovieCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()
        
    }

    // MARK: - Private methods
    private func setupUI() {
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .primaryDark
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    // MARK: - UICollectionViewCompositionalLayout
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension SearchResultsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getSearchData().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieCell.identifier, for: indexPath) as? UpcomingMovieCell
        else {
            return UICollectionViewCell()
        }
        
        guard let searchData = presenter?.getSearchData()[indexPath.row] else { return cell }
        cell.configure(for: searchData)
        return cell
    }
}

extension SearchResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

extension SearchResultsViewController: SearchViewProtocol {
    
    func updateUI() {
        Task {
            collectionView.reloadData()
        }
    }
}
