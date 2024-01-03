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
        label.textColor = .primaryBlue
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
        let convertModel = model?.compactMap {
            " • " + (removingHTMLEscapes(text: $0.value) ?? "") + "\n"
        }
        
        let output = convertModel?.joined(separator: "\n") ?? ""
        return output
    }
    
    //MARK: Remove HTML elements
    func removingHTMLEscapes(text: String?) -> String? {
        guard let data = text?.data(using: .utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("Ошибка при удалении HTML-тегов: \(error)")
            return nil
        }
    }
    
    //MARK: Configure
    func configure(_ model: PersonDoc?) {
        Task {
            guard let model = model else { return }
            let facts = convertModel(model: model.facts)
            let fullText = "Факты\n\n\(facts)"
            let attributedString = NSMutableAttributedString(string: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 5))
            factsLabel.attributedText = attributedString
        }
    }
    
    func configureAwards(_ model: DocAwards?) {
        Task {
            guard let model = model else { return }
            let awards = model.nomination?.award?.title ?? ""
            let awardNomination = model.nomination?.title ?? ""
            let awardMovie = model.movie?.name ?? ""
            let fullText = "Награды\n\n • \(awards) - \(awardNomination.lowercased()) “\(awardMovie)”"
            let attributedString = NSMutableAttributedString(string: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 7))
            awardsLabel.attributedText = attributedString
        }
    }
}
