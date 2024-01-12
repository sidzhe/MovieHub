//
//  FactsCell.swift
//  MovieHub
//
//  Created by sidzhe on 04.01.2024.
//

import UIKit
import SnapKit

final class FactsCell: UICollectionViewCell {
    
    //MARK: UI Elements
    private lazy var factLabel: UILabel = {
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
        
        contentView.addSubview(factLabel)
        
        factLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    //MARK: Configure
    func configure(_ model: String) {
        factLabel.text = model
    }
}
