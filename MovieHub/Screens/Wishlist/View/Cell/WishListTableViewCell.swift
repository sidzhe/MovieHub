//
//  WishListTableViewCell.swift
//  MovieHub
//
//  Created by Dmitry on 26.12.2023.
//

import UIKit
import Kingfisher

final class WishListTableViewCell: UITableViewCell {
    
    //MARK: - Parameters
    var callBackButton: (() -> Void)?
    static let reuseId = String(String(describing: WishListTableViewCell.self))
    
    private let darkBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .primarySoft
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    private lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 6
        return stack
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private lazy var heartImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: Constant.heartFill))
        view.tintColor = .red
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(tapHeart), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    //MARK: - Methods
    func setCellData(with model: Doc?) {
        genreLabel.text = model?.genres?.first?.name?.capitalized ?? Constant.none
        movieNameLabel.text = model?.name?.capitalized ?? Constant.none
        //rating label
        let type = model?.type?.capitalized ?? Constant.none
        let rating = model?.rating?.kp ?? 0.0
        setRatingLabelText(type: type , rating: rating)
        //imageView
        let url = model?.poster?.url ?? Constant.none
        leftImageView.kf.indicatorType = .activity
        let placeholder = UIImage(systemName: Constant.photoArtframe)
        leftImageView.kf.setImage(with: URL(string: url), placeholder: placeholder)
    }
    
    private func setViews() {
        heartImageView.addSubview(heartButton)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(darkBackgroundView)
        darkBackgroundView.addSubviews(hStack, heartImageView)
        hStack.addArrangedSubviews(leftImageView, vStack)
        vStack.addArrangedSubviews(genreLabel, movieNameLabel, ratingLabel)
    }
    
    private func setRatingLabelText(type: String, rating: Double) {
        //beginning
        let beginningAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray
        ]
        let beginningAttributeContainer = AttributeContainer(beginningAttributes)
        let beginningAttString = AttributedString(type,attributes: beginningAttributeContainer)
        
        //end
        let endAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .semibold),
            .foregroundColor: UIColor.orange
        ]
        let endAttContainer = AttributeContainer(endAttributes)
        let ratingString = String(format: Constant.format, rating)
        let endAttString = AttributedString("\(Constant.star) \(ratingString)", attributes: endAttContainer)
        let fullAttText = beginningAttString + " " + endAttString
        ratingLabel.attributedText = NSAttributedString(fullAttText)
    }
    
    @objc private func tapHeart() {
        callBackButton?()
    }
}


//MARK: - Constraints
extension WishListTableViewCell {
    private func setConstraints() {
        darkBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
        
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        leftImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(121.0 / 327.0)
        }
        
        heartImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.trailing.bottom.equalToSuperview().inset(12)
        }
        
        heartButton.snp.makeConstraints { make in
            make.size.equalTo(heartButton.snp.size)
        }
    }
}
