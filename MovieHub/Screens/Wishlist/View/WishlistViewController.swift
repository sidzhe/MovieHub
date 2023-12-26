//
//  WishlistViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class WishlistViewController: UIViewController {
    
    //MARK: Properties
    var presenter: WishlistPresenterProtocol?
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
    
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    //MARK: - Methods
    private func setViews() {
        view.backgroundColor = .gray
        view.addSubview(wishTableView)
        //wishTableView.frame = view.bounds
        
    }
    private func setConstraints() {
        wishTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}


//MARK: - Extension WishlistViewProtocol
extension WishlistViewController: WishlistViewProtocol {
    
}

extension WishlistViewController: UITableViewDelegate {
    
}

extension WishlistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.reuseId, for: indexPath) as? WishListTableViewCell else {
            print("UITableViewCell")
            return .init()}
        print("Custom cell")
        return cell
    }
    
    
}
