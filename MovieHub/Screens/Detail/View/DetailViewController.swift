//
//  DetailViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    //MARK: Properties
    var presenter: DetailPresenterProtocol?
    
    //MARK: UI Elements
    private let contentView = UIView()
    private var backgroundMaskedView = GradientView()
    
    private let infoBigStack = UIStackView.moviewInfoStack(spacing: 12)
    private let yearStack = UIStackView.moviewInfoStack(spacing: 4)
    private let durationStack = UIStackView.moviewInfoStack(spacing: 4)
    private let genreStack = UIStackView.moviewInfoStack(spacing: 4)
    private let rateStack = UIStackView.moviewInfoStack(spacing: 4)
    
    private let calendarImage = UIImageView(image: .calendarIcon)
    private let durationImage = UIImageView(image: .clockIcon)
    private let genreImage = UIImageView(image: .filmIcon)
    private let shareImage = UIImageView(image: .shareIcon)
    private let rateImage = UIImageView(image: .starIcon)
    
    private let yearLabel: UILabel = .movieInfoLabel()
    private let durationLabel = UILabel.movieInfoLabel()
    private let genreLabel = UILabel.movieInfoLabel()
    
    private lazy var firstStroke: UIView = createStroke()
    private lazy var  secondStroke: UIView = createStroke()
//    
//    private lazy var movieNavigationBar: MovieNavigationBar = {
//        let navigationBar = MovieNavigationBar(title: Constant.movieList, stateHeartButton: true)
//        navigationBar.navigationController = self.navigationController
//        return navigationBar
//    }()
    
    private lazy var descriptionStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isScrollEnabled = true
        scroll.contentInsetAdjustmentBehavior = .automatic
        return scroll
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.contentMode = .scaleAspectFit
        image.alpha = 0.24
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(size: 12)
        label.textColor = .primaryOrange
        return label
    }()
    
    private lazy var descriptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(size: 16)
        label.textColor = .white
        label.text = Constant.storyLine
        return label
    }()
    
    private lazy var trailerButton: UIButton = {
        let button = UIButton()
        button.setImage(.playIcon, for: .normal)
        button.setTitle(Constant.trailer, for: .normal)
        button.titleLabel?.font = UIFont.montserratMedium(size: 16)
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.backgroundColor = .primaryOrange
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.clipsToBounds = true
        button.backgroundColor = .primarySoft
        return button
    }()
    
    private lazy var descriptionTextLabel: UILabel = {
        let button = UILabel()
        button.font = .montserratRegular(size: 14)
        button.textColor = .white
        button.numberOfLines = 0
        button.lineBreakMode = .byWordWrapping
        return button
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constant.heart), for: .normal)
        button.setImage(UIImage(systemName: Constant.heartFill), for: .selected)
        button.tintColor = .red
        button.addTarget(self, action: #selector(tapHeart), for: .touchUpInside)
        return button
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        tapHeartButton()
        navigationController?.setupNavigationBar()
        navigationItem.title = Constant.movieList
        setupNavigationBarButton()
        
        presenter?.addRecentMovie()

    }
    
    private func setupNavigationBarButton() {
        let heartBarButton = UIBarButtonItem(image: UIImage(systemName: Constant.heart), style: .plain, target: self, action: #selector(tapHeart))
        navigationItem.rightBarButtonItem = heartBarButton
    }
    
    //MARK: Methods
    private func setupView() {
      //  view.addSubview(movieNavigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.backgroundColor = .primaryDark
        contentView.backgroundColor = .primaryDark
        scrollView.backgroundColor = .primaryDark
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(backgroundMaskedView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(infoBigStack)
        contentView.addSubview(rateStack)
        contentView.addSubview(trailerButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(descriptionStack)
        infoBigStack.addArrangedSubview(yearStack)
        infoBigStack.addArrangedSubview(firstStroke)
        infoBigStack.addArrangedSubview(durationStack)
        infoBigStack.addArrangedSubview(secondStroke)
        infoBigStack.addArrangedSubview(genreStack)
        yearStack.addArrangedSubview(calendarImage)
        yearStack.addArrangedSubview(yearLabel)
        durationStack.addArrangedSubview(durationImage)
        durationStack.addArrangedSubview(durationLabel)
        genreStack.addArrangedSubview(genreImage)
        genreStack.addArrangedSubview(genreLabel)
        rateStack.addArrangedSubview(rateImage)
        rateStack.addArrangedSubview(rateLabel)
        descriptionStack.addArrangedSubview(descriptionHeaderLabel)
        descriptionStack.addArrangedSubview(descriptionTextLabel)
        shareButton.addSubview(shareImage)
        
    }
    
    private func setupLayout() {
//        movieNavigationBar.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.horizontalEdges.equalToSuperview()
//            make.height.equalTo(45)
//        }
        
        scrollView.snp.makeConstraints { make in
//            make.top.equalTo(movieNavigationBar.snp.bottom)
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.width.equalToSuperview()
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(1.5)
            
        }
        posterImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(86)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
            
        }
        backgroundMaskedView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(backgroundImageView)
        }
        
        infoBigStack.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        rateStack.snp.makeConstraints { make in
            make.top.equalTo(infoBigStack.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        trailerButton.snp.makeConstraints { make in
            make.top.equalTo(rateStack.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(66)
            make.width.equalTo(115)
            make.height.equalTo(48)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(rateStack.snp.bottom).offset(24)
            make.trailing.equalToSuperview().inset(75)
            make.width.height.equalTo(48)
        }
        
        shareImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        descriptionStack.snp.makeConstraints { make in
            make.top.equalTo(trailerButton.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(100)
        }
    }
    
    // Создание разделительной линии между годом, продолжитенльностью и жанром
    func createStroke() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 16))
        let stroke = UIView()
        stroke.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.center = view.center
        view.addSubview(stroke)
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.layer.borderWidth = 1
        stroke.layer.borderColor = UIColor(red: 0.412, green: 0.412, blue: 0.455, alpha: 1).cgColor
        return view
    }
    
    func setTitles() {
        guard let presenter = presenter, let model = presenter.getDetailData() else { return }
        
        let year = String(model.year ?? 0)
        let lenght = String(model.movieLength ?? 0)
        let genre = model.genres?.first?.name ?? Constant.none
        let rating = String(model.rating?.kp ?? 0)
        let description = model.description ?? Constant.none
        guard let url = URL(string: model.poster?.url ?? Constant.none) else { return }
        
        yearLabel.text = year
        durationLabel.text = "\(lenght) \(Constant.minutes)"
        genreLabel.text = genre
        rateLabel.text = rating
        descriptionTextLabel.text = description
        backgroundImageView.kf.setImage(with: url)
        posterImageView.kf.setImage(with: url)
        
    }
    
    //MARK: - Display network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: Constant.requestError, message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: Target heart button
    private func tapHeartButton() {
//        movieNavigationBar.callBackButton = { [weak self] in self?.presenter?.checkFavorites() }
    }
    
    @objc private func tapHeart() {
        if let heartBarButton = navigationItem.rightBarButtonItem {
            if heartBarButton.image == UIImage(systemName: Constant.heart) {
                heartBarButton.image = UIImage(systemName: Constant.heartFill)
            } else {
                heartBarButton.image = UIImage(systemName: Constant.heart)
            }
        }
        presenter?.checkFavorites()
      
    }
}


//MARK: - Extension DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func updateUI() {
        Task { setTitles() }
    }
    
    func displayRequestError(_ error: RequestError) {
        Task { alertError(error) }
    }
}
