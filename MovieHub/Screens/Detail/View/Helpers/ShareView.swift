//
//  ShareView.swift
//  MovieHub
//
//  Created by Igor Guryan on 13.01.2024.
//

import UIKit

class ShareView: UIView {
    
    
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private var text = String()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 16
        return stack
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .primarySoft
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Поделиться в"
        label.font = .montserratSemiBold(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .primaryDark
        config.baseForegroundColor = .primaryGray
        config.image = .close.withRenderingMode(.alwaysTemplate)
        config.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        config.cornerStyle = .large
        button.configuration = config
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    
    @objc func closeTapped() {
        UIView.animate(
            withDuration: 0.5,
            animations: { [weak self] in self?.alpha = 0 },
            completion: { [weak self] _ in self?.removeFromSuperview() }
        )
    }
    
    
    
    init(frame: CGRect, movieID: String) {
        super.init(frame: frame)
        createShareButtons()
        setupView()
        setupLayout()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        addSubview(blurView)
        addSubview(container)
        container.addSubview(closeButton)
        container.addSubview(label)
        container.addSubview(stack)
        
    }
    
    func animate() {
        alpha = 0
        UIView.animate(withDuration: 0.5, animations: { self.alpha = 1 })
    }
    
    #warning("Поправить отображение иконок приложений для отправки")
    func createShareButtons() {
        let shareService = ShareService()
        let apps = shareService.getAvailableApps()
        apps.forEach {
            let button = UIButton(type: .system)
            button.setImage($0.icon.withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = .white
            button.imageView?.contentMode = .scaleAspectFill
            button.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 49, height: 49))
            }
            //            button.tag = $0.
            button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
            stack.addArrangedSubview(button)
        }
    }
    #warning("Дописать тут функцию")
    @objc
    private func shareTapped(_ sender: UIButton) {
//        UIApplication.shared.open(sender.getUrl(text))
    }
    
    func setupLayout() {
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        container.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(15)
        }
        
        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(64)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-51)
        }
        
        
        
    }
    
    
}
