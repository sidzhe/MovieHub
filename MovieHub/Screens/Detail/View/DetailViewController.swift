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
    
    private let calendarImage = UIImageView(image: UIImage(named: "calendarIcon.svg"))
    private let durationImage = UIImageView(image: UIImage(named: "clockIcon.svg"))
    private let genreImage = UIImageView(image: UIImage(named: "filmIcon.svg"))
    private let shareImage = UIImageView(image: UIImage(named: "shareIcon.svg"))
    
    private let yearLabel: UILabel = .movieInfoLabel("2021")
    private let durationLabel = UILabel.movieInfoLabel("146 Minutes")
    private let genreLabel = UILabel.movieInfoLabel("Action")
    
    private lazy var firstStroke: UIView = createStroke()
    private lazy var  secondStroke: UIView = createStroke()
    private let rateImage = UIImageView(image: UIImage(named: "starIcon.svg"))
    
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
        image.image = UIImage(named: "poster.jpeg")
        image.contentMode = .scaleAspectFit
        image.alpha = 0.24
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var posterImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "poster.jpeg")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(size: 12)
        label.textColor = .primaryOrange
        label.text = "4.5"
        return label
    }()
        
    private lazy var descriptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(size: 16)
        label.textColor = .white
        label.text = "Story Line"
        return label
    }()
    
    private lazy var trailerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playIcon.svg"), for: .normal)
        button.setTitle("Trailer", for: .normal)
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
        button.text = "For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. MoreFor the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. MoreFor the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. MoreFor the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. MoreFor the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. MoreFor the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. More"
        return button
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        
    }
    //MARK: Methods
    private func setupView() {
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
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
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
        let genre = model.genres?.first?.name ?? ""
        let rating = String(model.rating?.kp ?? 0)
        let description = model.description ?? ""
        guard let url = URL(string: model.poster?.url ?? "") else { return }
        
        yearLabel.text = year
        durationLabel.text = "\(lenght) minutes"
        genreLabel.text = genre
        rateLabel.text = rating
        descriptionTextLabel.text = description
        backgroundImageView.kf.setImage(with: url)
        posterImageView.kf.setImage(with: url)
        
    }
    
    //MARK: - Display network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: "Request error", message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
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

#Preview { DetailViewController() }
