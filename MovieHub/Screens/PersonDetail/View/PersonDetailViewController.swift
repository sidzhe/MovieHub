//
//  PersonDetailViewController.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import UIKit
import SnapKit

final class PersonDetailViewController: UIViewController {
    
    //MARK: Properties
    var presenter:  PersonDetailPresenterProtocol?
    
    //MARK: UI Elements
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width / 3, height: 250)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self
        view.register(PopularCell.self, forCellWithReuseIdentifier: "PersonCell")
        return view
    }()
    
    private let avatar: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 16)
        label.textColor = .white
        label.text = "Мэтью Макконахи"
        return label
    }()
    
    private lazy var birdDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Дата рождения\n4 ноября, 1969 * 50 лет"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var careerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Карьера\nАктер, продюссер"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var awardsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Награды\nЗолотой глобус"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var factsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Факты\nПросто красава"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var  moviesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Фильмы"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setTitles()
    }
    
    //MARK: Setup UI
    private func setupViews() {
        view.backgroundColor = .primaryDark
        
        stackView.addArrangedSubview(awardsLabel)
        stackView.addArrangedSubview(factsLabel)
        stackView.addArrangedSubview(moviesLabel)
        
        view.addSubview(avatar)
        view.addSubview(nameLabel)
        view.addSubview(birdDayLabel)
        view.addSubview(careerLabel)
        view.addSubview(stackView)
        view.addSubview(collectionView)
        
        avatar.snp.makeConstraints { make in
            make.width.equalTo(135)
            make.height.equalTo(213)
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().inset(24)
        }
        
        birdDayLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalTo(avatar.snp.right).offset(20)
            make.right.equalToSuperview().inset(24)
        }
        
        careerLabel.snp.makeConstraints { make in
            make.top.equalTo(birdDayLabel.snp.bottom).offset(12)
            make.left.equalTo(avatar.snp.right).offset(20)
            make.right.equalToSuperview().inset(24)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(avatar.snp.bottom).offset(34)
            make.horizontalEdges.equalToSuperview().inset(22)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(stackView.snp.bottom)
            make.bottom.equalToSuperview().inset(90)
        }
    }
    
    private func setTitles() {
        guard let model = presenter?.getPersonDetailData() else { return }
      
        
    }
    
    //MARK: - Display network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: "Request error", message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}


//MARK: - Extension UICollectionViewDataSource
extension PersonDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getSearchData()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCell", for: indexPath) as? PopularCell
        guard let model = presenter?.getSearchData() else { return UICollectionViewCell() }
        cell?.configure(category: model[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}
 
//MARK: - Extension UICollectionViewDelegate
extension PersonDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - Extension PersonDetailViewProtocol
extension PersonDetailViewController: PersonDetailViewProtocol {
    
    //MARK: Update UI
    func updateUI() {
        Task {
            setTitles()
            collectionView.reloadData()
        }
    }
    
    //MARK: Get display error
    func displayRequestError(_ error: RequestError) {
        Task { alertError(error) }
    }
}
