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
    private lazy var wishTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(WishListTableViewCell.self, forCellReuseIdentifier: WishListTableViewCell.reuseId)
        table.rowHeight = 107+16
        table.separatorStyle = .none
        table.backgroundColor = .clear
        return table
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        
    }
    
    //MARK: ViewWillAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.updateModel()
        
    }
    
    //MARK: - Methods
    private func setViews() {
        title = Constant.wishList
        view.backgroundColor = .primaryDark
        view.addSubview(wishTableView)
        
        wishTableView.snp.makeConstraints { make in
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

//MARK: - Extension UITableViewDataSource
extension WishlistViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getWishListData().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.reuseId, for: indexPath) as? WishListTableViewCell
        let model = presenter?.getWishListData()
        cell?.callBackButton = { [weak self] in
            self?.presenter?.checkWishElement(id: model?[indexPath.row].id ?? 0)
            self?.presenter?.updateModel()
        }
        
        cell?.setCellData(with: model?[indexPath.row])
        return cell ?? UITableViewCell()
    }
}


//MARK: - Extension UITableViewDataSource
extension WishlistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.routeToDetail(index: indexPath.row)
    }
}


//MARK: - Extension WishlistViewProtocol
extension WishlistViewController: WishlistViewProtocol {
    
    func updateUI() {
        Task { wishTableView.reloadData() }
    }
    
    func displayRequestError(error: String) {
        Task { alertError(error) }
    }
}

