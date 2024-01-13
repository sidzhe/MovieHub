//
//  UpcomingMovieCell.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 31.12.2023.
//

import UIKit
import Kingfisher

final class UpcomingMovieCell: UICollectionViewCell {
    
    static let identifier = Constant.upcomingMovieCell
    
    // MARK: - Views
    private lazy var posterImageView: UIImageView = _posterImageView
    private lazy var activityIndicator: UIActivityIndicatorView = _activityIndicator
    private lazy var blurView: UIVisualEffectView = _blurView
    private lazy var starImage: UIImageView = _starImage
    private lazy var yearImage: UIImageView = _calendarImage
    private lazy var movieLengthImage: UIImageView = _clockImage
    private lazy var categoryImage: UIImageView = _movieImage
    
    private let ratingLabel: UILabel = makeLabel(
        fontSize: 16,
        textColor: .primaryOrange
    )
    
    private let nameLabel: UILabel = makeLabel(
        fontSize: 16,
        textColor: .white
    )
    
    private let yearLabel: UILabel = makeLabel(
        fontSize: 12,
        textColor: .primaryGray
    )
    
    private let movieLengthLabel: UILabel = makeLabel(
        fontSize: 12,
        textColor: .primaryGray
    )
    
    private let categoryLabel: UILabel = makeLabel(
        fontSize: 12,
        textColor: .primaryGray
    )
    
    private lazy var yearStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [yearImage, yearLabel])
        stackView.axis = .horizontal
        stackView.spacing = Constants.interSpacing
        return stackView
    }()
    
    private lazy var movieLengthStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieLengthImage, movieLengthLabel])
        stackView.axis = .horizontal
        stackView.spacing = Constants.interSpacing
        return stackView
    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [categoryImage, categoryLabel])
        stackView.axis = .horizontal
        stackView.spacing = Constants.interSpacing
        
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            yearStackView,
            movieLengthStackView,
            categoryStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = Constants.verticalSpacing
        return stackView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constant.fatalError)
    }
    
    // MARK: - For SearchedMovie
    func configure(with searchedMovie: Doc) {
        
        guard let url = searchedMovie.poster?.url
                ?? searchedMovie.poster?.previewURL else  { return }
        
        let urlString = URL(string: url)
        
        posterImageView.kf.setImage(with: urlString, placeholder: UIImage(named: Constant.placeholder), options: nil, progressBlock: { [weak self] (_, _) in
              self?.activityIndicator.startAnimating()
            }, completionHandler: { [weak self] (_) in
              self?.activityIndicator.stopAnimating()
            })
        
        nameLabel.text = searchedMovie.name ?? searchedMovie.alternativeName
        yearLabel.text = searchedMovie.year != nil ? "\(searchedMovie.year!)" : Constant.notData
        movieLengthLabel.text = "\(searchedMovie.movieLength ?? 0) \(Constant.minutesBig)"
        categoryLabel.text = searchedMovie.type?.capitalized ?? Constant.none
        ratingLabel.text = String(format: Constant.format, (searchedMovie.rating?.kp ?? searchedMovie.rating?.imdb) as Double? ?? 0.0)
    }
    
    // MARK: - Private methods
    private func setupView() {
       contentView.addSubview(posterImageView)
       contentView.addSubview(nameLabel)
       contentView.addSubview(infoStackView)
        posterImageView.addSubview(blurView)
        posterImageView.addSubview(activityIndicator)
        blurView.contentView.addSubview(starImage)
        blurView.contentView.addSubview(ratingLabel)
    }
    
    private func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(Constants.verticalSpacing * 2)
            make.leading.equalTo(posterImageView.snp.trailing).offset(Constants.interSpacing)
            make.trailing.equalToSuperview().inset(24)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.width.equalTo(contentView.snp.width).multipliedBy(1.0 / 2.7)
            make.height.equalTo(contentView.snp.height)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.verticalSpacing * 3)
            make.leading.equalTo(posterImageView.snp.trailing).offset(Constants.interSpacing)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom).offset(-Constants.interSpacing)
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
        
        activityIndicator.center = posterImageView.center
    }
}

//MARK: Static methods & properties
private extension UpcomingMovieCell {
    
    var _posterImageView: UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }
    
    var _activityIndicator: UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .medium)
        return indicator
      }
    
    var _blurView: UIVisualEffectView  {
        let view = UIVisualEffectView()
        let effect = UIBlurEffect(style: .regular)
        view.effect = effect
        view.clipsToBounds = true
        view.layer.cornerRadius = 6
        return view
    }
    
    var _starImage: UIImageView {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.starFill)
        view.tintColor = .primaryOrange
        return view
    }
    
    var _calendarImage: UIImageView {
        let view = UIImageView()
        view.image = .calendar
        return view
    }
    
    var _clockImage: UIImageView {
        let view = UIImageView()
        view.image = .clock
        return view
    }
    
    var _movieImage: UIImageView {
        let view = UIImageView()
        view.image = .movie
        return view
    }
    
    static func makeLabel(fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = textColor
        label.font = UIFont.montserratSemiBold(size: fontSize)
        label.numberOfLines = 0
        return label
    }
    
    struct Constants {
        static let verticalSpacing: CGFloat = 15
        static let horizontalSpacing: CGFloat = 20
        static let interSpacing: CGFloat = 8
    }
}

