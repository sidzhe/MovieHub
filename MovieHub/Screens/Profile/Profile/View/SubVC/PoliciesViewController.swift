//
//  PoliciesViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 12.01.2024.
//

import UIKit

final class PoliciesViewController: UIViewController {
    
    //MARK: - Properties
    
    let termsLabelText = "Terms"
    let termsText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames."
    let secondTermsLabelText = "Changes to the Service and/or Terms:"
    let secondTermsText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eget ornare quam vel facilisis feugiat amet sagittis arcu, tortor. Sapien, consequat ultrices morbi orci semper sit nulla. Leo auctor ut etiam est, amet aliquet ut vivamus. Odio vulputate est id tincidunt fames."
    
    
    //MARK: - User interface elements
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        scroll.frame = view.bounds
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    private lazy var termsLabel: UILabel = {
        var emailLabel = UILabel()
        emailLabel.textAlignment = .left
        emailLabel.font = .montserratSemiBold(size: 16)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = .white
        return emailLabel
    }()
    
    private lazy var secondTermsLabel: UILabel = {
        var emailLabel = UILabel()
        emailLabel.textAlignment = .left
        emailLabel.font = .montserratSemiBold(size: 16)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = .white
        return emailLabel
    }()
    
    private lazy var termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .primaryDark
        textView.font = .montserratMedium(size: 18)
        textView.textColor = .white
        return textView
    }()
    private lazy var secondTermsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .primaryDark
        textView.font = .montserratMedium(size: 18)
        textView.textColor = .white
        return textView
    }()
    
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupConstraints()
        navigationController?.setupNavigationBar()
    }
    
    //MARK: - Private methods
    
    private func setupView() {
        navigationItem.title = "Правила"
        view.backgroundColor = .primaryDark
        navigationController?.navigationBar.topItem?.title = ""
        
        // Setup view
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(
            termsLabel,
            termsTextView,
            secondTermsLabel,
            secondTermsTextView
        )
        
        // Setup label's
        termsLabel.text = termsLabelText
        secondTermsLabel.text = secondTermsLabelText
        
        // Setup text view's
        termsTextView.text = termsText
        secondTermsTextView.text = secondTermsText
    }
}

//MARK: - Extension

extension PoliciesViewController {
    
    enum Constans {
        static let labelHeight: CGFloat = 19
        static let tenPoints: CGFloat = 10
        static let twentyPoints: CGFloat = 20
        static let leadingLabelInsets: CGFloat = 24
        static let termsLabelWidth: CGFloat = 80
        static let topInsets: CGFloat = 60
        static let textViewHeight: CGFloat = 320
    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(Constans.twentyPoints)
            make.leading.equalTo(contentView).offset(Constans.leadingLabelInsets)
            make.height.equalTo(Constans.labelHeight)
            make.width.equalTo(Constans.termsLabelWidth)
        }
        
        termsTextView.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.bottom).offset(Constans.tenPoints)
            make.leading.trailing.equalTo(contentView).inset(Constans.leadingLabelInsets)
            make.height.equalTo(Constans.textViewHeight)
        }
        
        secondTermsLabel.snp.makeConstraints { make in
            make.top.equalTo(termsTextView.snp.bottom).offset(Constans.twentyPoints)
            make.leading.equalTo(contentView).offset(Constans.leadingLabelInsets)
            make.height.equalTo(Constans.labelHeight)
            make.width.equalTo(Constans.textViewHeight)
        }
        
        secondTermsTextView.snp.makeConstraints { make in
            make.top.equalTo(secondTermsLabel.snp.bottom).offset(Constans.tenPoints)
            make.leading.trailing.equalTo(contentView).inset(Constans.leadingLabelInsets)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
}



