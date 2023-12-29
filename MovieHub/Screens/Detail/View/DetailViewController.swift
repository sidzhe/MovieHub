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
    
    private lazy var backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.image = UIImage(named: "poster.jpeg")
        iv.contentMode = .scaleAspectFit
        iv.alpha = 0.24
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    private var backgroundMaskedView = GradientView()
    
    private lazy var posterImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "poster.jpeg")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var infoBigStack = UIStackView.moviewInfoStack(spacing: 12)
    
    private lazy var yearStack = UIStackView.moviewInfoStack(spacing: 4)

    private lazy var calendarImage = UIImageView(image: UIImage(named: "calendarIcon.svg"))
    private lazy var yearLabel: UILabel = .movieInfoLabel("2021")
    
    private lazy var durationStack = UIStackView.moviewInfoStack(spacing: 4)
    private lazy var durationImage = UIImageView(image: UIImage(named: "clockIcon.svg"))
    private lazy var durationLabel = UILabel.movieInfoLabel("146 Minutes")
    
    private lazy var firstStroke: UIView = createStroke()
    private lazy var secondStroke: UIView = createStroke()
    
    private lazy var genreStack = UIStackView.moviewInfoStack(spacing: 4)
    private lazy var genreImage = UIImageView(image: UIImage(named: "filmIcon.svg"))
    private lazy var genreLabel = UILabel.movieInfoLabel("Action")
    
    private lazy var rateStack = UIStackView.moviewInfoStack(spacing: 4)
    private lazy var rateImage = UIImageView(image: UIImage(named: "starIcon.svg"))
    private lazy var rateLabel: UILabel = {
        let lb = UILabel()
        lb.font = .montserratSemiBold(size: 12)
        lb.textColor = .secondaryOrange
        lb.text = "4.5"
        return lb
    }()
    
    private lazy var trailerButton: UIButton = {
        let bt = UIButton()
        bt.layer.cornerRadius = 24
        bt.clipsToBounds = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .secondaryOrange
        return bt
    }()
    
    private lazy var trailerStack = UIStackView.moviewInfoStack(spacing: 8)
    private lazy var trailerImage = UIImageView(image: UIImage(named: "playIcon.svg"))
    private lazy var trailerLabel: UILabel = {
        let lb = UILabel()
        lb.font = .montserratMedium(size: 16)
        lb.textColor = .white
        lb.text = "Trailer"
        return lb
    }()
    
    private lazy var shareButton: UIButton = {
        let bt = UIButton()
        bt.layer.cornerRadius = 24
        bt.clipsToBounds = true
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .primarySoft
        return bt
    }()
    
    private lazy var shareImage = UIImageView(image: UIImage(named: "shareIcon.svg"))
    
    private lazy var descriptionHeaderLabel: UILabel = {
        let lb = UILabel()
        lb.font = .montserratSemiBold(size: 16)
        lb.textColor = .white
        lb.text = "Story Line"
        return lb
    }()
    
    private lazy var descriptionTextLabel: UILabel = {
        let lb = UILabel()
        lb.font = .montserratRegular(size: 14)
        lb.textColor = .white
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        lb.text = "For the first time in the cinematic history of Spider-Man, our friendly neighborhood hero's identity is revealed, bringing his Super Hero responsibilities into conflict with his normal life and putting those he cares about most at risk. More"
        return lb
    }()
    
    private lazy var castHeaderLabel: UILabel = {
        let lb = UILabel()
        lb.font = .montserratSemiBold(size: 16)
        lb.textColor = .white
        lb.text = "Cast and Crew"
        return lb
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
        
        
        
    }
    //MARK: Methods
    private func setupView() {
        view.backgroundColor = .primaryDark
        view.addSubview(backgroundImageView)
        view.addSubview(backgroundMaskedView)
        view.addSubview(posterImageView)
        view.addSubview(infoBigStack)
        view.addSubview(rateStack)
        view.addSubview(trailerButton)
        view.addSubview(shareButton)
        view.addSubview(descriptionHeaderLabel)
        view.addSubview(descriptionTextLabel)
        view.addSubview(castHeaderLabel)
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
        trailerButton.addSubview(trailerStack)
        trailerStack.addArrangedSubview(trailerImage)
        trailerStack.addArrangedSubview(trailerLabel)
        shareButton.addSubview(shareImage)
        
    }
    
    private func setupLayout() {
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
        
        trailerStack.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        shareImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        descriptionHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(trailerButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        descriptionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionHeaderLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        castHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionTextLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
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
}




//MARK: - Extension DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    
}

#Preview { DetailViewController()}
