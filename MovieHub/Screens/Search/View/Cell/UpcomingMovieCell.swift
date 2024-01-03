//
//  UpcomingMovieCell.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 31.12.2023.
//

import UIKit

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
        view.backgroundColor = .label
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
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
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func configure(with upcomingMovie: Doc) {
        guard let url = URL(string: upcomingMovie.poster?.url ?? upcomingMovie.poster?.previewURL ?? "") else { return }
        Task(priority: .userInitiated) { [weak self] in self?.posterImageView.kf.setImage(with: url) }
        
        nameLabel.text = upcomingMovie.name ?? upcomingMovie.alternativeName
        yearLabel.text = String("\(upcomingMovie.year)")
        durationLabel.text = "\(String(describing: upcomingMovie.movieLength)) Minutes"
        categoryLabel.text = upcomingMovie.genres?.first?.name
        ratingLabel.text = String(format: "Rating: %.1f", upcomingMovie.rating?.kp ?? 0.0)
    }
    
    
    // MARK: - Private methods
    private func setupView() {
        addSubview(movieContentView)
        movieContentView.addSubview(posterImageView)
        movieContentView.addSubview(nameLabel)
        movieContentView.addSubview(yearLabel)
        movieContentView.addSubview(durationLabel)
        movieContentView.addSubview(categoryLabel)
        blurView.contentView.addSubview(starImage)
        blurView.contentView.addSubview(ratingLabel)
    }
    
    private func setConstraints() {
        movieContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.verticalSpacing)
            make.leading.equalToSuperview().offset(Constants.horizontalSpacing)
            make.trailing.equalToSuperview().offset(-Constants.horizontalSpacing)
            make.bottom.equalToSuperview().offset(-Constants.horizontalSpacing)
        }

        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(movieContentView.snp.top)
            make.leading.equalTo(movieContentView.snp.leading)
            make.width.equalTo(movieContentView.snp.width).multipliedBy(1.0 / 3.8)
            make.height.equalTo(movieContentView.snp.height)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieContentView.snp.top).offset(Constants.interSpacing)
            make.leading.equalTo(movieContentView.snp.trailing).offset(Constants.interSpacing)
            make.trailing.equalTo(movieContentView.snp.trailing).offset(-Constants.horizontalSpacing)
        }

        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.interSpacing)
            make.leading.equalTo(movieContentView.snp.trailing).offset(Constants.interSpacing)
            make.trailing.equalTo(movieContentView.snp.trailing).offset(-Constants.horizontalSpacing)
        }

        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(Constants.interSpacing + 4)
            make.leading.equalTo(movieContentView.snp.trailing).offset(Constants.interSpacing)
            make.trailing.equalTo(movieContentView.snp.trailing).offset(-Constants.horizontalSpacing)
            make.bottom.equalTo(movieContentView.snp.bottom).offset(-Constants.verticalSpacing * 12)
        }
        
        blurView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(62)
            make.top.left.equalToSuperview().inset(8)
        }
        
        starImage.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.left.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.left.equalTo(starImage.snp.right).inset(-5)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(5)
        }
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

