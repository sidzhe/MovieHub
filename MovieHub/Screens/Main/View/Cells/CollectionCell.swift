//
//  CollectionCell.swift
//  MovieHub
//
//  Created by sidzhe on 27.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CollectionCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.contentMode = .scaleToFill
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratExtraBold(size: 16)
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratSemiBold(size: 15)
        return label
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundImage.image = nil
        
    }
    
    //MARK: Methods
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        backgroundImage.addSubview(nameLabel)
        backgroundImage.addSubview(countLabel)
        contentView.addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.bottom.equalTo(countLabel.snp.top).inset(-25)
            make.right.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    
    //MARK: Configure
    func configure(_ model: DocCollect) {
        nameLabel.text = model.name
        countLabel.text = "\(model.moviesCount ?? 0) \(Constant.moviesCollection)"
        guard let url = URL(string: model.cover?.url ?? model.cover?.previewUrl ?? Constant.none) else { return }
        backgroundImage.kf.setImage(with: url)
    }
}
