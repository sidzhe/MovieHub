//
//  AwardCell.swift
//  MovieHub
//
//  Created by sidzhe on 04.01.2024.
//

import UIKit
import SnapKit

final class AwardCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private let awardIcon = UIImageView()
    
    private lazy var awardLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
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
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.primaryBlue.cgColor
        
        contentView.addSubview(awardIcon)
        contentView.addSubview(awardLabel)
        
        awardIcon.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(100)
        }
        
        awardLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(awardIcon.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
        }
    }
    
    //MARK: Configure
    func configure(_ model: DocAwards) {
        let awards = model.nomination?.award?.title ?? Constant.none
        let awardNomination = model.nomination?.title ?? Constant.none
        let awardMovie = model.movie?.name ?? Constant.none
        awardLabel.text = "\(awards) \n\(awardNomination) \n\(awardMovie)"
        awardIcon.image = awardLoad(awards)
    }
    
    //MARK: Load award image
    private func awardLoad(_ imageName: String) -> UIImage {
        switch imageName {
        case Constant.oscarRu:
            return .oscar
        case Constant.cannFest:
            return .cann
        case Constant.goldGlobe:
            return .globe
        default:
            return .award
        }
    }
}
