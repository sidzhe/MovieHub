//
//  DetailCinemaViewController.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailCinemaViewController: UIViewController {
    
    //MARK: Properties
    var presenter: DetailCinemaPresenterProtocol?
    
    //MARK: UI Elements
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratBold(size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var generalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    private lazy var imageStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addImageObjectToStack()
        setLabelsName()
        setupViews()
        
    }
    
    //MARK: Setup UI
    private func setupViews() {
        view.backgroundColor = .primaryDark
        navigationController?.navigationBar.barTintColor = .primaryDark
        
        generalStackView.addArrangedSubview(nameLabel)
        generalStackView.addArrangedSubview(adressLabel)
        generalStackView.addArrangedSubview(descriptionLabel)
        generalStackView.addArrangedSubview(contactLabel)
        generalStackView.addArrangedSubview(imageStackView)
        scrollView.addSubview(generalStackView)
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        generalStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(90)
        }
    }
    
    //MARK: Add cinema images
    private func addImageObjectToStack() {
        guard let presenter = presenter else { return }
        
        presenter.cinemaModel.image?.forEach {
            let imageView = UIImageView()
            guard let url = URL(string: $0) else { return }
            imageView.kf.setImage(with: url)
            imageStackView.addArrangedSubview(imageView)
            
            imageView.snp.makeConstraints { make in
                make.height.equalTo(200)
            }
        }
    }
    
    //MARK: Set ciname labels
    private func setLabelsName() {
        nameLabel.text = presenter?.cinemaModel.name
        
        let adressLabelText = "• Ардес \n\n\(presenter?.cinemaModel.adress ?? "")"
        let attributedAdress = NSMutableAttributedString(string: adressLabelText)
        attributedAdress.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 7))
        adressLabel.attributedText = attributedAdress
        
        let descriptionLabelText = "• О кинотеатре \n\n\(presenter?.getCinemaDescription() ?? "")"
        let attributedDescription = NSMutableAttributedString(string: descriptionLabelText)
        attributedDescription.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 14))
        descriptionLabel.attributedText = attributedDescription
        
        let contactLabelText = "• Телефон \n\n+\(presenter?.cinemaModel.phone ?? "")"
        let attributedContact = NSMutableAttributedString(string: contactLabelText)
        attributedContact.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 9))
        guard contactLabelText.count > 13 else { return }
        contactLabel.attributedText = attributedContact
    }
}


//MARK: - Extension DetailCinemaViewProtocol
extension DetailCinemaViewController: DetailCinemaViewProtocol {
    
}
