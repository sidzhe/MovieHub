//
//  WishlistViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class WishlistViewController: UIViewController {
    //TODO: - Delete later
    let movieNamesArray = ["Spider-Man", "Spider-Man Spider-Man", "Spider-Man Spider-Man Spider-ManSpider-Man Spider-Man Spider-Man"]
    
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
    
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    //MARK: - Methods
    private func setViews() {
        view.backgroundColor = .black
        view.addSubview(wishTableView)
        wishTableView.frame = view.bounds
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WishListTableViewCell.reuseId, for: indexPath) as? WishListTableViewCell else {return .init()}
        //TODO: - Make correct method to set cell's data
        cell.setMovieName(name: movieNamesArray[indexPath.row])
        return cell
    }
    
    
}
