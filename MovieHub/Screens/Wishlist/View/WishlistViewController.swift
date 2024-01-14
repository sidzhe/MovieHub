//
//  WishlistViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit
import SnapKit

final class WishlistViewController: UIViewController {
    
    //MARK: Properties
    var presenter: WishlistPresenterProtocol?
    
    //MARK: UI Elements
    private lazy var wishColectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: view.frame.width - 10, height: view.frame.height / 5)
        let table = UICollectionView(frame: .zero, collectionViewLayout: layout)
        table.delegate = self
        table.dataSource = self
        table.register(WishListCell.self, forCellWithReuseIdentifier: WishListCell.reuseId)
        table.backgroundColor = .clear
        return table
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
    }
    
    //MARK: ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.updateModel()
        
    }
    
    //MARK: - Setup UI
    private func setViews() {
        title = Constant.wishList
        view.backgroundColor = .primaryDark
        view.addSubview(wishColectionView)
        
        wishColectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview().inset(90)
        }
    }
    
    //MARK: Alert
    private func alertError(_ error: String) {
        let alert = UIAlertController(title: Constant.requestError, message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - Extension UICollectionViewDataSource
extension WishlistViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getWishListData().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishListCell.reuseId, for: indexPath) as? WishListCell
        let model = presenter?.getWishListData()
        cell?.setCellData(with: model?[indexPath.row])
        cell?.callBackButton = { [weak self] in
            guard let self = self else { return }
            self.presenter?.removeItem(at: indexPath)
        }
        
        return cell ?? UICollectionViewCell()
    }
}


//MARK: - Extension UITableViewDataSource
extension WishlistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.routeToDetail(index: indexPath.row)
    }
}


//MARK: - Extension WishlistViewProtocol
extension WishlistViewController: WishlistViewProtocol {
    
    func updateUI() {
        Task { wishColectionView.reloadData() }
    }
    
    func displayRequestError(error: String) {
        Task { alertError(error) }
    }
    
    func removeItemFromCollection(at indexPath: IndexPath) {
        wishColectionView.performBatchUpdates { [weak self] in
            self?.wishColectionView.deleteItems(at: [indexPath])
        }
    }
}

