//
//  CinemaCell.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import UIKit
import SnapKit

final class CinemaCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratBold(size: 15)
        return label
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratMedium(size: 13)
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratMedium(size: 13)
        return label
    }()
    
    private lazy var imageChevron: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .primaryGray
        return image
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup UI
    private func setupViews() {
        contentView.backgroundColor = .primarySoft
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 6
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(adressLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(imageChevron)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(50)
        }
        
        adressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(50)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(adressLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(50)
        }
        
        imageChevron.snp.makeConstraints { make in
            make.size.equalTo(15)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    //MARK: Configure
    func configure(model: GlobeCinema) {
        nameLabel.text = model.name
        adressLabel.text = model.adress
        distanceLabel.text = "Расстояние \(String(format: "%.1f", model.distance)) км."
    }
}
