//
//  MovieListCell.swift
//  MovieHub
//
//  Created by sidzhe on 10.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class MovieListCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private let posterImage = UIImageView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratMedium(size: 16)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImage.image = nil
        
    }
    
    //MARK: Setup UI
    private func setupViews() {
        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 8
        
        addSubview(posterImage)
        addSubview(titleLabel)
        
        posterImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(posterImage.snp.bottom).inset(-12)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    //MARK: Configure
    func configure(_ doc: Doc) {
        titleLabel.text = doc.name
        guard let url = URL(string: doc.backdrop?.url ?? Constant.none) else { return }
        let processor = DownsamplingImageProcessor(size: CGSize(width: 400, height: 400))
            |> ResizingImageProcessor(referenceSize: CGSize(width: 400, height: 400), mode: .aspectFill)

        posterImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}
