//
//  GlobeCustomCell.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import UIKit
import SnapKit

final class GlobeCustomCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private lazy var imageIcon = UIImageView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratMedium(size: 13)
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratMedium(size: 13)
        return label
    }()
    
    private lazy var upSeparate: UIView = {
        let view = UIView()
        view.backgroundColor = .primarySoft
        return view
    }()
    
    private lazy var imageChevron: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: Constant.chevronRight)
        image.tintColor = .primaryGray
        return image
    }()
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    //MARK: Setup UI
    private func setupViews() {
        imageIcon.tintColor = .primaryBlue
        contentView.backgroundColor = .clear
        contentView.addSubview(upSeparate)
        contentView.addSubview(imageIcon)
        contentView.addSubview(nameLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(imageChevron)
        
        upSeparate.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(1)
        }
        
        imageIcon.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(imageIcon.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints { make in
            make.right.equalTo(imageChevron.snp.left).inset(-10)
            make.centerY.equalToSuperview()
        }
        
        imageChevron.snp.makeConstraints { make in
            make.size.equalTo(15)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    //MARK: Configure
    func configure(nameLabel: String, city: String, imageName: String) {
        self.nameLabel.text = nameLabel
        self.cityLabel.text = city.localized()
        self.imageIcon.image = UIImage(systemName: imageName)
    }
}
