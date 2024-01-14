//
//  PersonCell.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 07.01.2024.
//

import UIKit
import Kingfisher

final class PersonCell: UICollectionViewCell {
    
    static let identifier = Constant.personCell
    
    // MARK: - Views
    private lazy var personImageView: UIImageView = _personImageView
    private lazy var personName: UILabel = _personName
    private lazy var activityIndicator: UIActivityIndicatorView = _activityIndicator
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    // MARK: - Method for setup data to elements in every cell
    func configure(person: DocPerson) {
        let urlString = URL(string: person.photo)
        
        personImageView.kf.setImage(with: urlString, placeholder: UIImage(named: Constant.placeholder), options: nil, progressBlock: { [weak self] (_, _) in
            self?.activityIndicator.startAnimating()
        }, completionHandler: { [weak self] (_) in
            self?.activityIndicator.stopAnimating()
        })
        
        if person.name == Constant.none {
            personName.text = person.enName
        } else {
            personName.text = person.name
        }
        
    }
    
    // MARK: - Subviews
    private func addSubviews() {
        contentView.addSubview(personImageView)
        contentView.addSubview(personName)
        personImageView.addSubview(activityIndicator)
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        
        personImageView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.centerX.equalToSuperview()
        }
        
        personName.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(personImageView.snp.bottom).offset(10)
        }
        activityIndicator.center = personImageView.center
        
        personImageView.layer.cornerRadius = 50
        personImageView.layer.masksToBounds = true
    }
}

// MARK: - Extension for setup elements
private extension PersonCell {
    
    var _personImageView: UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    var _personName: UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.montserratSemiBold(size: 12)
        label.textColor = .white
        return label
    }
    
    var _activityIndicator: UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
    }
}
