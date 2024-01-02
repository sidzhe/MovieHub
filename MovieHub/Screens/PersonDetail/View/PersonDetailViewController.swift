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
        label.text = "Дата рождения /n4 ноября, 1969 * 50 лет"
        return label
    }()
    
    private lazy var careerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Карьера /nАктер, продюссер"
        return label
    }()
    
    private lazy var awardsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Награды /nЗолотой глобус"
        return label
    }()
    
    private lazy var factsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Факты /nПросто красава"
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
        view.axis = .horizontal
        view.spacing = 20
        return view
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
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
            make.top.equalTo(nameLabel.snp.bottom).inset(12)
            make.left.equalTo(avatar.snp.right).offset(20)
            make.right.equalToSuperview().inset(24)
        }
        
        careerLabel.snp.makeConstraints { make in
            make.top.equalTo(birdDayLabel.snp.bottom).inset(12)
            make.left.equalTo(avatar.snp.right).offset(20)
            make.right.equalToSuperview().inset(24)
        }
    }
}


//MARK: - Extension PersonDetailViewProtocol
extension PersonDetailViewController: PersonDetailViewProtocol {
    
}
