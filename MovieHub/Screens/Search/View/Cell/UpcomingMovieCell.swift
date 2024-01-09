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
    
    // MARK: - Views
    
    private lazy var posterImageView: UIImageView = _posterImageView
    private lazy var movieContentView: UIView = _movieContentView
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
        yearLabel.text = model.year != nil ? "\(model.year!)" : "No Data"
        movieLengthLabel.text = "\(upcomingMovie.movieLength ?? 0) Minutes"
        categoryLabel.text = model.type?.capitalized ?? ""
        ratingLabel.text = String(format: "%.1f", (model.rating?.kp ?? model.rating?.imdb) as Double? ?? 0.0)
    }
    
    // MARK: - For SearchedMovie
    func configure(for searchedMovie: Doc) {
        
        let url = URL(string: searchedMovie.poster?.url ?? "")
        
        Task(priority: .userInitiated) { [weak self] in self?.posterImageView.kf.setImage(with: url) }
        
        nameLabel.text = searchedMovie.name ?? searchedMovie.alternativeName
        yearLabel.text = String("\(searchedMovie.year)")
        movieLengthLabel.text = "\(String(describing: searchedMovie.movieLength)) Minutes"
        categoryLabel.text = searchedMovie.type?.capitalized
        ratingLabel.text = String(format: "%.1f", searchedMovie.rating?.kp ?? 0.0)
    }
    
    // MARK: - Private methods
    private func setupView() {
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        addSubview(movieContentView)
        movieContentView.addSubview(posterImageView)
        movieContentView.addSubview(nameLabel)
        movieContentView.addSubview(infoStackView)
        posterImageView.addSubview(blurView)
        blurView.contentView.addSubview(starImage)
        blurView.contentView.addSubview(ratingLabel)
    }
    
    private func setConstraints() {
        movieContentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(movieContentView.snp.top).offset(Constants.verticalSpacing * 2)
            make.leading.equalTo(posterImageView.snp.trailing).offset(Constants.interSpacing)
            make.trailing.equalToSuperview().inset(24)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(movieContentView.snp.top)
            make.leading.equalTo(movieContentView.snp.leading)
            make.width.equalTo(movieContentView.snp.width).multipliedBy(1.0 / 2.5)
            make.height.equalTo(movieContentView.snp.height)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.verticalSpacing * 3)
            make.leading.equalTo(posterImageView.snp.trailing).offset(Constants.interSpacing)
            make.trailing.equalTo(movieContentView.snp.trailing)
            make.bottom.lessThanOrEqualTo(movieContentView.snp.bottom).offset(-Constants.interSpacing)
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
private extension UpcomingMovieCell {
    
    var _posterImageView: UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        return view
    }
    
    var _movieContentView: UIView {
        let view = UIView()
        view.backgroundColor = .primaryDark
        return view
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
        view.image = UIImage(systemName: "star.fill")
        view.tintColor = .primaryOrange
        return view
    }
    
    var _calendarImage: UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "calendar")
        return view
    }
    
    var _clockImage: UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "clock")
        return view
    }
    
    var _movieImage: UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "movie")
        return view
    }
    
    static func makeLabel(fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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

