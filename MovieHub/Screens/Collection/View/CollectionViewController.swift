//
//  CollectionViewController.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit
import SnapKit

final class CollectionViewController: UIViewController {
    
    //MARK: Properties
    var presenter: CollectionPresenterProtocol?
    
    //MARK: UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: view.frame.width, height: view.frame.height / 3.5)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.identifier)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    //MARK: SetupViews
    private func setupViews() {
        navigationController?.navigationBar.barTintColor = .primaryDark
        view.backgroundColor = .primaryDark
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(90)
        }
    }
    
    //MARK: - Display network error
    private func alertError(_ error: String) {
        let alert = UIAlertController(title: "Request error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}


//MARK: - Extension UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCollectionModel().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.identifier, for: indexPath) as? MovieListCell
        guard let model = presenter?.getCollectionModel() else { return UICollectionViewCell () }
        cell?.configure(model[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}


//MARK: - Extension UICollectionViewDelegate
extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.routeToDetail()
    }
}

//MARK: - Extension CollectionViewProtocol
extension CollectionViewController: CollectionViewProtocol {
    
    func updateUI() {
        Task { collectionView.reloadData() }
    }
    
    func displayError(_ error: String) {
        Task { alertError(error) }
    }
}
