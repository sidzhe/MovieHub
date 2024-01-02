//
//  PopularCell.swift
//  MovieHub
//
//  Created by sidzhe on 27.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class PopularCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private lazy var posterImage: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratSemiBold(size: 14)
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = UIFont.montserratMedium(size: 10)
        return label
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        let effect = UIBlurEffect(style: .light)
        view.effect = effect
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    //MARK: UI Elements
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryOrange
        label.font = UIFont.montserratSemiBold(size: 17)
        return label
    }()
    
    private lazy var starImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .primaryOrange
        return view
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImage.image = nil
        
    }
    
    //MARK: Methods
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        footerView.addSubview(nameLabel)
        footerView.addSubview(categoryLabel)
        
        blurView.contentView.addSubview(starImage)
        blurView.contentView.addSubview(ratingLabel)
        
        contentView.addSubview(posterImage)
        contentView.addSubview(footerView)
        contentView.addSubview(blurView)
        
        posterImage.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(55)
        }
        
        footerView.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(12)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        blurView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(62)
            make.top.right.equalToSuperview().inset(8)
        }
        
        starImage.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.left.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(starImage.snp.right).inset(-5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(5)
        }
    }
    
    func configure(category: Doc) {
        guard let url = URL(string: category.poster?.url ?? category.poster?.previewURL ?? "") else { return }
        Task { posterImage.kf.setImage(with: url) }
        nameLabel.text = category.name ?? category.alternativeName
        categoryLabel.text = category.genres?.first?.name
        ratingLabel.text = String(format: "%.1f", category.rating?.kp ?? 0.0)

    }
}
