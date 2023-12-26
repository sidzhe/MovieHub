//
//  WishListTableViewCell.swift
//  MovieHub
//
//  Created by Dmitry on 26.12.2023.
//

import UIKit

class WishListTableViewCell: UITableViewCell {
    
    //MARK: - Parameters
    static let reuseId = String(String(describing: WishListTableViewCell.self))
    
    private let darkBackgroundView: UIView = {
       let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .yellow
        return stack
    }()
    private lazy var leftImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "spiderman"))
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        return stack
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    private func setViews() {
        contentView.backgroundColor = .clear
        contentView.addSubview(darkBackgroundView)
        darkBackgroundView.addSubview(hStack)
        hStack.addArrangedSubviews(leftImageView, vStack)
    }

}

extension WishListTableViewCell {
    private func setConstraints() {
        darkBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 24, bottom: 8, right: 24))
        }
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        leftImageView.snp.makeConstraints { make in
            make.height.equalTo(leftImageView.snp.width).multipliedBy(83.0/121.0)
        }
    }
}
