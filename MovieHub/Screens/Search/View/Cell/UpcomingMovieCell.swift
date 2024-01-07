//
//  UpcomingMovieCell.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 31.12.2023.
//

import UIKit
import Kingfisher

final class UpcomingMovieCell: UICollectionViewCell {
    
    static let identifier = "UpcomingMovieCell"
    
    private lazy var posterImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryDark
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        let effect = UIBlurEffect(style: .light)
        view.effect = effect
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let ratingLabel: UILabel = makeLabel(
        fontSize: 17,
        textColor: .primaryOrange
    )
    
    private lazy var starImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .primaryOrange
        return view
    }()
    
    private let nameLabel: UILabel = makeLabel(
        fontSize: 16,
        textColor: .white
    )
    
    private let yearLabel: UILabel = makeLabel(
        fontSize: 12,
        textColor: .primaryGray
    )
    
    private let durationLabel: UILabel = makeLabel(
        fontSize: 12,
        textColor: .primaryGray
    )
    
    private let categoryLabel: UILabel = makeLabel(
        fontSize: 12,
        textColor: .primaryGray
    )
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, yearLabel, durationLabel, categoryLabel])
        stackView.axis = .vertical
        stackView.spacing = Constants.interSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - For UpcomingMovie
    func configure(with upcomingMovie: UpcomingDoc) {
      guard let model = upcomingMovie.sequelsAndPrequels?.first,
            let urlString = model.poster?.url ?? model.poster?.previewURL,
            let url = URL(string: urlString) else { return }
      
      Task(priority: .userInitiated) { [weak self] in
        self?.posterImageView.kf.setImage(with: url)
      }
      
      nameLabel.text = model.name ?? model.alternativeName
      yearLabel.text = String("\(model.year)")
      durationLabel.text = "\(String(describing: model.rating)) Minutes"
      categoryLabel.text = model.type
      ratingLabel.text = String(format: "Rating: %.1f", model.rating?.kp ?? 0.0)
    }
    
    // MARK: - For SearchedMovie
    func configure(for searchedMovie: Doc) {
        
        let url = URL(string: searchedMovie.poster?.url ?? "")
                
        Task(priority: .userInitiated) { [weak self] in self?.posterImageView.kf.setImage(with: url) }
        
        nameLabel.text = searchedMovie.name ?? searchedMovie.alternativeName
        yearLabel.text = String("\(searchedMovie.year)")
        durationLabel.text = "\(String(describing: searchedMovie.rating)) Minutes"
        categoryLabel.text = searchedMovie.type
        ratingLabel.text = String(format: "Rating: %.1f", searchedMovie.rating?.kp ?? 0.0)
    }
    
    // MARK: - Private methods
    private func setupView() {
        addSubview(movieContentView)
        movieContentView.addSubview(posterImageView)
        movieContentView.addSubview(infoStackView)
//        blurView.contentView.addSubview(starImage)
//        blurView.contentView.addSubview(ratingLabel)
    }
    
    private func setConstraints() {
        
        movieContentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(movieContentView.snp.top)
            make.leading.equalTo(movieContentView.snp.leading)
            make.width.equalTo(movieContentView.snp.width).multipliedBy(1.0 / 1.5)
            make.height.equalTo(movieContentView.snp.height)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(movieContentView.snp.top).offset(Constants.verticalSpacing)
            make.leading.equalTo(posterImageView.snp.trailing).offset(Constants.interSpacing)
            make.trailing.equalTo(movieContentView.snp.trailing)
            make.bottom.lessThanOrEqualTo(movieContentView.snp.bottom).offset(-Constants.interSpacing)
        }
        
//        blurView.snp.makeConstraints { make in
//            make.height.equalTo(24)
//            make.width.equalTo(62)
//            make.top.left.equalToSuperview().inset(8)
//        }
//        
//        starImage.snp.makeConstraints { make in
//            make.size.equalTo(18)
//            make.left.equalToSuperview().inset(5)
//            make.centerY.equalToSuperview()
//        }
//        
//        ratingLabel.snp.makeConstraints { make in
//            make.left.equalTo(starImage.snp.right).inset(-5)
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().inset(5)
//        }
    }
}

//MARK: Static methods & properties
extension UpcomingMovieCell {
    private static func makeLabel(fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = textColor
        label.font = UIFont.montserratSemiBold(size: fontSize)
        label.numberOfLines = 0
        return label
    }
    
    struct Constants {
        static let verticalSpacing: CGFloat = 4
        static let horizontalSpacing: CGFloat = 20
        static let interSpacing: CGFloat = 8
    }
}

