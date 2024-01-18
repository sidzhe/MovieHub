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
    
    private lazy var firstArrowImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "arrowBut")
        return img
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
    
    private lazy var secondArrowImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "arrowBut")
        return img
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
    }

    func addTargetForSecondButton(target: Any?, action: Selector, for event: UIControl.Event) {
      secondButton.addTarget(target, action: action, for: event)
    }
    
    //MARK: - Private method
    
    private func setupView() {
        self.addSubviews(
            viewLabel,
            firstButton,
            firstImage,
            firstArrowImage,
            lineView,
            secondButton,
            secondImage,
            secondArrowImage
        )
        
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 0.8
    }
}
extension GeneralView {
    enum Constants {
        static let twoPoints: CGFloat = 2
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let thiryPoints: CGFloat = 30
        static let fiftyFivePoints: CGFloat = 55
        static let sixtyPoints: CGFloat = 60
        static let ninetyPoints: CGFloat = 90
        static let twoHundredPoints: CGFloat = 200
    }
    
    func setupConstraints() {
        viewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.tenPoints)
            make.leading.equalToSuperview().offset(Constants.tenPoints)
            make.height.equalTo(Constants.twentyPoints)
            make.width.equalTo(Constants.ninetyPoints)
        }
        
        firstButton.snp.makeConstraints { make in
            make.top.equalTo(viewLabel.snp.bottom).offset(Constants.twentyPoints)
            make.leading.equalTo(firstImage.snp.trailing).offset(Constants.tenPoints)
            make.trailing.equalToSuperview().offset(-Constants.fiftyFivePoints)
            make.height.equalTo(Constants.fiftyFivePoints)
        }
        
        firstImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.thiryPoints)
            make.width.height.equalTo(Constants.thiryPoints)
            make.centerY.equalTo(firstButton)
        }
        
        firstArrowImage.snp.makeConstraints { make in
            make.leading.equalTo(firstButton.snp.trailing).offset(Constants.tenPoints)
            make.centerY.equalTo(firstButton)
            make.height.width.equalTo(Constants.thiryPoints)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(firstButton.snp.bottom).offset(Constants.tenPoints)
            make.leading.equalToSuperview().offset(Constants.thiryPoints)
            make.trailing.equalToSuperview().offset(-Constants.fiftyFivePoints)
            make.height.equalTo(Constants.twoPoints)
        }
        
        secondButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(Constants.tenPoints)
            make.leading.equalTo(firstButton)
            make.trailing.equalToSuperview().offset(-Constants.fiftyFivePoints)
            make.height.equalTo(Constants.fiftyFivePoints)
        }
        
        secondImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.thiryPoints)
            make.width.height.equalTo(Constants.thiryPoints)
            make.centerY.equalTo(secondButton)
        }
        
        secondArrowImage.snp.makeConstraints { make in
            make.leading.equalTo(secondButton.snp.trailing).offset(Constants.tenPoints)
            make.centerY.equalTo(secondButton)
            make.height.width.equalTo(Constants.thiryPoints)
        }
    }
}
