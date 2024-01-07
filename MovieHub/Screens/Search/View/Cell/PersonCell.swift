//
//  PersonCell.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 07.01.2024.
//

import UIKit
import Kingfisher

final class PersonCell: UICollectionViewCell {
    
    static let identifier = "PersonCell"
    
    // MARK: - Views
    private lazy var personImageView: UIImageView = _personImageView
    private lazy var personName: UILabel = _personName
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method for setup data to elements in every cell
    func configure(person: DocPerson) {
        let urlString = person.photo
        let url = URL(string: urlString)
        Task(priority: .userInitiated) { [weak self] in
            self?.personImageView.kf.setImage(with: url)
        }
        
        personName.text = "\(person.name)"
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(personImageView)
        contentView.addSubview(personName)
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        
        personImageView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.top.centerX.equalToSuperview()
        }
        
        personName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(personImageView.snp.bottom).offset(10)
        }
    }
}

// MARK: - Extension for setup elements
private extension PersonCell {
    
    var _personImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 75
        return imageView
    }
    
    var _personName: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.montserratSemiBold(size: 12)
        label.textColor = .white
        return label
    }
}
