//
//  GeneralView.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 18.01.2024.
//

import UIKit

final class GeneralView: UIView {
    
    private lazy var viewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.montserratSemiBold(size: 18)
        return label
    }()
    
    private lazy var firstImage: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        return img
    } ()
    
    let firstButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .montserratMedium(size: 14)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var firstArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowBut"), for: .normal)
        return button
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return view
    }()
    
    let secondButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .montserratMedium(size: 14)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private lazy var secondImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var secondArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowBut"), for: .normal)
        return button
    }()
    
    //   MARK: - Initialize
    init(
        labelText: String?,
        firstButtonTitle: String?,
        firstImage: String,
        secondButtonTitle: String?,
        secondImage: String
    ) {
        super.init(frame: .infinite)
        viewLabel.text = labelText
        firstButton.setTitle(firstButtonTitle, for: .normal)
        self.firstImage.image = UIImage(named: firstImage)
        secondButton.setTitle(secondButtonTitle, for: .normal)
        self.secondImage.image = UIImage(named: secondImage)
        
        setupView()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public method
    func addTargetForFirstButton(target: Any?, action: Selector, for event: UIControl.Event) {
        firstButton.addTarget(target, action: action, for: event)
        firstArrowButton.addTarget(target, action: action, for: event)
    }
    
    func addTargetForSecondButton(target: Any?, action: Selector, for event: UIControl.Event) {
        secondButton.addTarget(target, action: action, for: event)
        secondArrowButton.addTarget(target, action: action, for: event)
    }
    
    //MARK: - Private method
    
    private func setupView() {
        self.addSubviews(
            viewLabel,
            firstButton,
            firstImage,
            firstArrowButton,
            lineView,
            secondButton,
            secondImage,
            secondArrowButton
        )
        
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 0.8
    }
}
extension GeneralView {
    
    func setupConstraints() {
        viewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(viewLabel.snp.bottom).offset(20)
            make.leading.equalTo(firstImage.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-55)
            make.height.equalTo(55)
        }
        
        firstImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.width.height.equalTo(30)
            make.centerY.equalTo(firstButton)
        }
        
        firstArrowButton.snp.makeConstraints { make in
            make.leading.equalTo(firstButton.snp.trailing).offset(10)
            make.centerY.equalTo(firstButton)
            make.height.width.equalTo(30)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(2)
        }
        
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.leading.equalTo(firstButton)
            make.trailing.equalToSuperview().offset(-55)
            make.height.equalTo(55)
        }
        
        secondImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.width.height.equalTo(30)
            make.centerY.equalTo(secondButton)
        }
        
        secondArrowButton.snp.makeConstraints { make in
            make.leading.equalTo(secondButton.snp.trailing).offset(10)
            make.centerY.equalTo(secondButton)
            make.height.width.equalTo(30)
        }
    }
}
