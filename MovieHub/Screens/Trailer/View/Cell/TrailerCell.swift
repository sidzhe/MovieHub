//
//  TrailerCell.swift
//  MovieHub
//
//  Created by sidzhe on 13.01.2024.
//

import UIKit
import SnapKit

final class TrailerCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private lazy var personImage: UIImageView = {
        let image = UIImageView()
        image.image = .animation81
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratSemiBold(size: 14)
        label.text = "Matt"
        return label
    }()
    
    private lazy var majorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = UIFont.montserratMedium(size: 10)
        label.text = "Matt"
        return label
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
        contentView.addSubview(personImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(majorLabel)
        
        personImage.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.right.equalTo(personImage.snp.right).offset(8)
            make.top.equalTo(personImage.snp.top).inset(3)
        }
        
        majorLabel.snp.makeConstraints { make in
            make.right.equalTo(personImage.snp.right).offset(8)
            make.top.equalTo(nameLabel.snp.top).offset(4)
        }
    }
    
    //MARK: Configure
    func configure(person: Person) {
        nameLabel.text = person.name
        majorLabel.text = person.profession
        guard let url = URL(string: person.photo ?? Constant.none) else { return }
        personImage.kf.setImage(with: url)
    }
}
