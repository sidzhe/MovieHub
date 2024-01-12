//
//  MovieNavigationBar.swift
//  MovieHub
//
//  Created by sidzhe on 10.01.2024.
//

import UIKit
import SnapKit

final class MovieNavigationBar: UIView {
    
    //MARK: Properties
    var navigationController: UINavigationController?
    var callBackButton: (() -> Void)?
    
    private lazy var navigationTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratSemiBold(size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return button
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constant.heart), for: .normal)
        button.setImage(UIImage(systemName: Constant.heartFill), for: .selected)
        button.tintColor = .red
        button.addTarget(self, action: #selector(tapHeart), for: .touchUpInside)
        return button
    }()
    
    private let blurViewBack: UIVisualEffectView = {
        let view = UIVisualEffectView()
        let effect = UIBlurEffect(style: .dark)
        view.effect = effect
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let blurViewButton: UIVisualEffectView = {
        let view = UIVisualEffectView()
        let effect = UIBlurEffect(style: .dark)
        view.effect = effect
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    //MARK: Inits
    init(title: String, stateHeartButton: Bool = false) {
        super.init(frame: .zero)
        self.navigationTitle.text = title
        self.blurViewButton.isHidden = !stateHeartButton
        self.heartButton.isHidden = !stateHeartButton
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    //MARK: Target back
    @objc private func tapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: SetupView
    private func setupViews() {
        navigationTitle.textAlignment = .center
        
        blurViewBack.contentView.addSubview(backButton)
        blurViewButton.contentView.addSubview(heartButton)

        addSubview(navigationTitle)
        addSubview(blurViewBack)
        addSubview(blurViewButton)

        navigationTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        blurViewBack.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        
        backButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        heartButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.center.equalToSuperview()
        }
        
        blurViewButton.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(24)
        }
    }
    
    @objc private func tapHeart() {
        heartButton.isSelected.toggle()
        callBackButton?()
    }
}


