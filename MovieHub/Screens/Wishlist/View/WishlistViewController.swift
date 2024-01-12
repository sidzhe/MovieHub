//
//  WishlistViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class WishlistViewController: UIViewController {
    
    private var wishListModel: [Doc]? {
        didSet {
            guard let wishListModel, wishListModel.count > 0 else {return}
            wishTableView.reloadData()
        }
    }
    //MARK: Properties
    var presenter: WishlistPresenterProtocol?
    private lazy var wishTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(WishListTableViewCell.self, forCellReuseIdentifier: WishListTableViewCell.reuseId)
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 107+16
        table.separatorStyle = .none
        table.backgroundColor = .clear
        return table
    }()
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWishListData()
    }
    
    //MARK: - Methods
    
    private func getWishListData() {
        presenter?.getWishListData()
    }
    private func setViews() {
        view.backgroundColor = .primaryDark
        view.addSubview(wishTableView)
        wishTableView.frame = view.bounds
        title = "Wishlist"
    }
    
}


//MARK: - Extension WishlistViewProtocol
extension WishlistViewController: WishlistViewProtocol {
    func updateUI(model: [Doc]?) {
        DispatchQueue.main.async {
            self.wishListModel = model
        }
    }
    
    func displayRequestError(error: String) {
        let alert = UIAlertController(title: "Request error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}

extension WishlistViewController: UITableViewDelegate {
    
}

extension WishlistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wishListModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.reuseId, for: indexPath) as? WishListTableViewCell else {return .init()}
        cell.setCellData(with: wishListModel?[indexPath.row])
        return cell
    }
    
    
}
