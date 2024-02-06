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
    
    let user = "Guest"
    
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
    
    private lazy var emailView: CustomTextField = {
        let view = CustomTextField(
            placeholder: "Введите email",
            labelText: "email"
        )
        return view
    }()
    
    private lazy var passwordView: CustomTextField = {
        let view = CustomTextField(
            placeholder: "Введите пароль",
            labelText: "пароль"
        )
        view.textField.isSecureTextEntry = true
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
    
    private var isRegistering: Bool = true {
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
            guestButton.isHidden = false
        } else {
            titleLabel.text = "Авторизация"
            nameView.isHidden = true
            checkButton.setTitle("Создать новый аккаунт?", for: .normal)
            authButton.setTitle("Авторизировать", for: .normal)
            guestButton.isHidden = true
        }
        nameView.textField.text = ""
        emailView.textField.text = ""
        passwordView.textField.text = ""
    }
    
    private func guestButtonTap() {
        presenter?.routeToTabBar()
    }
    
    private func checkButtonTap() {
        isRegistering.toggle()
    }
    
    private func authButtonTap() {
        if isRegistering {
            registerNewUser()
        } else {
            authUser()
        }
    }
    
    private func authUser() {
        guard let inputEmail = emailView.textField.text, isValidEmail(inputEmail),
              let inputPassword = passwordView.textField.text,
              isValidPassword(inputPassword)
        else {
            showAlert("Неверный Ввод. Пожалуйста, проверьте адрес электронной почты и пароль.")
            return
        }
        presenter?.loginUser(email: inputEmail, password: inputPassword)
     
    }
    
    private func registerNewUser() {
        guard let inputName = nameView.textField.text, isValidName(inputName),
              let inputEmail = emailView.textField.text, isValidEmail(inputEmail),
              let inputPassword = passwordView.textField.text,
              isValidPassword(inputPassword)
        else {
            showAlert("Неверный Ввод. Пожалуйста, проверьте свое имя, адрес электронной почты и пароль.")
            return
        }
        
        let user = createUserWith(
            name: inputName,
            email: inputEmail, 
            password: inputPassword,
            avatarImage: nil
        )
        presenter?.addNewUser(user: user)
        isRegistering = false
    }
    
    func createUserWith(name: String, email: String, password: String, avatarImage: UIImage?) -> AuthModel {
        let user = AuthModel(
            name: name,
            email: email, 
            password: password,
            avatar: nil
        )
        return user
    }
    
    private func showAlert(_ text: String) {
        let alert = AlertFactory.makeErrorAlert(with: text)
        present(alert, animated: true)
    }
    
    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            isValidName(text) ? nameView.setValid() : nameView.setError()
        }
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            isValidEmail(text) ? emailView.setValid() : emailView.setError()
        }
    }
    
    private func isValidName(_ name: String) -> Bool {
        guard !name.isEmpty else {
            return false
        }
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        guard !email.isEmpty else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        guard !password.isEmpty else {
            return false
        }
        return true
    }
}

extension AuthViewController: AuthViewProtocol {
    
    func displayError(error: String) {
        showAlert(error)
    }
}

//MARK: - SetupViews
extension AuthViewController {
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(guestButton)
        view.addSubview(stackForViews)
        stackForViews.addArrangedSubviews(nameView)
        stackForViews.addArrangedSubview(emailView)
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
        
        emailView.snp.makeConstraints { make in
            make.height.equalTo(53)
            make.width.equalTo(380)
        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(20)
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
