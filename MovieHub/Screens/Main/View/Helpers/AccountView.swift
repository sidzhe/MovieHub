//
//  AccountView.swift
//  MovieHub
//
//  Created by sidzhe on 27.12.2023.
//

import UIKit
import SnapKit

final class AccountView: UIView {
    
    //MARK: Propeties
    var callBackButton: (() -> Void)?
    var callBackGlobe: (() -> Void)?
    
    //MARK: UI Elements
    lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, Гость".localized()
        label.font = UIFont.montserratSemiBold(size: 16)
        label.textColor = .white
        return label
    }()
    
    private var buttonsView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private var movieButtonView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(tapHeart), for: .touchUpInside)
        return button
    }()
    
    private lazy var globeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "globe"), for: .normal)
        button.tintColor = .primaryBlue
        button.addTarget(self, action: #selector(tapGlobe), for: .touchUpInside)
        return button
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    private func setupViews() {
        buttonsView.addSubview(heartButton)
        movieButtonView.addSubview(globeButton)
        
        addSubview(avatar)
        addSubview(nameLabel)
        addSubview(buttonsView)
        addSubview(movieButtonView)
        
        avatar.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(25)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(avatar.snp.right).offset(15)
        }
        
        buttonsView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(30)
        }
        
        movieButtonView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalTo(buttonsView.snp.left).inset(-15)
        }
        
        heartButton.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.center.equalToSuperview()
        }
        
        globeButton.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.center.equalToSuperview()
        }
    }
    
    @objc private func tapHeart() {
        callBackButton?()
    }
    
    @objc private func tapGlobe() {
        callBackGlobe?()
    }
}
