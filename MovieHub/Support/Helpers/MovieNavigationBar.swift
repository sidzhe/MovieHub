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
    
    private lazy var navigationTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratSemiBold(size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var backgroungView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return button
    }()
    
    //MARK: Inits
    init(title: String) {
        super.init(frame: .zero)
        self.navigationTitle.text = title
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Target back
    @objc private func tapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: SetupView
    private func setupViews() {
        navigationTitle.textAlignment = .center
        
        backgroungView.addSubview(backButton)
        
        addSubview(navigationTitle)
        addSubview(backgroungView)

        navigationTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backgroungView.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        
        backButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}


