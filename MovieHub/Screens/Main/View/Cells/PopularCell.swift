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
    
    //MARK: - Methods
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        footerView.addSubview(nameLabel)
        footerView.addSubview(categoryLabel)
        
        contentView.addSubview(posterImage)
        contentView.addSubview(footerView)
        
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
        
    }
    
    func configure(category: Doc) {
        nameLabel.text = category.name ?? category.alternativeName
        categoryLabel.text = category.genres?.first?.name
        guard let url = URL(string: category.poster?.url ?? category.poster?.previewURL ?? "") else { return }
        posterImage.kf.setImage(with: url)
    }
}
