//
//  PersonHeader.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import UIKit
import SnapKit

final class PersonHeader: UICollectionReusableView {
    
    //MARK: UI Elements
    private lazy var factsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var  moviesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.text = "Фильмы"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private lazy var awardsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup UI
    private func setupViews() {
        stackView.addArrangedSubview(awardsLabel)
        stackView.addArrangedSubview(factsLabel)
        stackView.addArrangedSubview(moviesLabel)
        addSubview(stackView)
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    //MARK: Convert
    private func convertModel(model: [BirthPlace]?) -> String {
        model?.compactMap { "• " + ($0.value ?? "") }.joined(separator: "\n") ?? ""
    }
    
    //MARK: Configure
    func configure(_ model: PersonDoc) {
        let facts = convertModel(model: model.facts)
        awardsLabel.text = "Награды\nЗолотой глобус"
        factsLabel.text = "Факты\n\(facts)"
    }
}
