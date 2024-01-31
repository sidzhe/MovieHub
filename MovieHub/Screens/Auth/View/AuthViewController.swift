//
//  AuthViewController.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 30.01.2024.
//

import UIKit
import SnapKit

final class AuthViewController: UIViewController {
    //MARK: Properties
    var presenter: AuthPresenterProtocol?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Регистрация"
        label.font = UIFont.montserratSemiBold(size: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var nameView: CustomTextField = {
        let view = CustomTextField(
            placeholder: "Введите имя",
            labelText: "имя"
        )
        return view
    }()
    
    private lazy var loginView: CustomTextField = {
        let view = CustomTextField(
            placeholder: "Введите логин",
            labelText: "логин"
        )
        return view
    }()
    
    private lazy var passwordView: CustomTextField = {
        let view = CustomTextField(
            placeholder: "Введите пароль",
            labelText: "пароль"
        )
        return view
    }()
    
    private let stackForViews: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 30
        return stack
    }()
    
    private lazy var checkButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "У Вас уже есть аккаунт?",
            color: .primaryBlue,
            backgroundColor: .clear,
            cornerRadius: 0) { [weak self] in
            self?.checkButtonTap()
        }
    }()

    private lazy var guestButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "Войти как гость",
            color: .white,
            backgroundColor: .clear,
            cornerRadius: 0) { [weak self] in
            self?.guestButtonTap()
        }
    }()

    private lazy var authButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "Зарегистировать",
            color: .white,
            backgroundColor: .primaryBlue,
            cornerRadius: 26) { [weak self] in
            self?.authButtonTap()
        }
    }()
    
    private var isRegistering: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryDark
        
        setupViews()
        setConstraint()
    }
    
//MARK: - private methods
    private func updateUI() {
        if isRegistering {
            titleLabel.text = "Регистрация"
            nameView.isHidden = false
            checkButton.setTitle("У Вас уже есть аккаунт?", for: .normal)
            authButton.setTitle("Зарегистрировать", for: .normal)
            guestButton.isHidden = true
        } else {
            titleLabel.text = "Авторизация"
            nameView.isHidden = true
            checkButton.setTitle("Хотите зарегистрироваться?", for: .normal)
            authButton.setTitle("Авторизировать", for: .normal)
            guestButton.isHidden = false
        }
        nameView.textField.text = ""
        loginView.textField.text = ""
        passwordView.textField.text = ""
    }
    
    private func guestButtonTap() {
       
    }
    
    private func checkButtonTap() {
        isRegistering.toggle()
    }
    
    private func authButtonTap() {

    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(guestButton)
        view.addSubview(stackForViews)
        stackForViews.addArrangedSubviews(nameView)
        stackForViews.addArrangedSubview(loginView)
        stackForViews.addArrangedSubview(passwordView)
        stackForViews.addArrangedSubviews(authButton)
        stackForViews.addArrangedSubview(checkButton)
    }
    
    private func setConstraint() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.centerX.equalToSuperview()
            make.width.equalTo(380)
        }
        
        nameView.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(380)
        }
        
        loginView.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(380)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(loginView.snp.bottom).offset(20)
            make.height.equalTo(53)
            make.width.equalTo(380)
        }
        
        authButton.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(380)
        }
        
        checkButton.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(380)
        }
        
        guestButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
            make.width.equalTo(380)
        }
        
        stackForViews.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(53)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(350)
        }
    }
}

extension AuthViewController: AuthViewProtocol {
    
    
}
