//
//  WishListTableViewCell.swift
//  MovieHub
//
//  Created by Dmitry on 26.12.2023.
//

import UIKit

final class WishListTableViewCell: UITableViewCell {
    
    //MARK: - Parameters
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
        let view = UIImageView(image: UIImage(named: "spiderman"))
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    private let vStack: UIStackView = {
        let stack = UIStackView()
        //stack.backgroundColor = .cyan
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 6
        return stack
    }()
    
    private var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Spider-Man"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    private var ratingLabel: UILabel = {
        let label = UILabel()
        //beginning
        let beginningAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray
        ]
        let beginningAttributeContainer = AttributeContainer(beginningAttributes)
        let beginningAttString = AttributedString(("Movie "),attributes: beginningAttributeContainer)
        
        //end
        let endAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12, weight: .semibold),
            .foregroundColor: UIColor.orange
        ]
        let endAttContainer = AttributeContainer(endAttributes)
        let endAttString = AttributedString("★ 4.5", attributes: endAttContainer)
        let fullAttText = beginningAttString + endAttString
        label.attributedText = NSAttributedString(fullAttText)
        return label
    }()
    private var heartImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "heart.fill"))
        view.tintColor = .red
        return view
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func setMovieName(name: String) {
        movieNameLabel.text = name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func setViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(darkBackgroundView)
        darkBackgroundView.addSubviews(hStack, heartImageView)
        hStack.addArrangedSubviews(leftImageView, vStack)
        vStack.addArrangedSubviews(genreLabel, movieNameLabel, ratingLabel)
    }
    
}

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
    }
}
