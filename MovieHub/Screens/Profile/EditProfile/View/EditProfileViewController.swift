import UIKit
import PhotosUI

final class EditProfileViewController: UIViewController {
    
    var presenter: EditProfilePresenterProtocol?
    
    lazy var avatarImageView: UIImageView = _avatarImageView
    
    lazy var avatarEditButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "avatarEditButton2"), for: .normal)
        button.backgroundColor = .primaryDark
        button.layer.cornerRadius = 25
        button.tintColor = .primaryBlue
        button.layer.borderColor = UIColor.primaryDark.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(avatarEditButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.text = "Tiffany"
        nameLabel.font = .montserratSemiBold(size: 20)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var emailLabel: UILabel = {
        var emailLabel = UILabel()
        emailLabel.textAlignment = .center
        emailLabel.text = "tiffany@gmail.com"
        emailLabel.font = .montserratMedium(size: 17)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = .gray
        return emailLabel
    }()
    
    private lazy var saveButton: UIButton = {
        return ButtonFactory.makeButton(
            title: "Сохранить изменения",
            color: .white,
            backgroundColor: .primaryBlue,
            cornerRadius: 26) { [weak self] in
                self?.saveButtonTap()
            }
    }()
    
    private lazy var nameView: CustomTextField = {
        let view = CustomTextField(placeholder: "ваше имя...", labelText: "Ваше имя")
        view.textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingDidEnd)
        return view
    }()
    
    private lazy var nameErrorLabel: UILabel = {
        var label = UILabel()
        label.text = "* Имя уже существует"
        label.font = .montserratMedium(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.isHidden = true
        return emailLabel
    }()
    
    private lazy var emailView: CustomTextField = {
        let view = CustomTextField(placeholder: "ваш email...", labelText: "Email")
        view.textField.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingDidEnd)
        return view
    }()
    
    private lazy var emailErrorLabel: UILabel = {
        var label = UILabel()
        label.text = "* Email уже существует"
        label.font = .montserratMedium(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.isHidden = true
        return emailLabel
    }()
    
    private lazy var passwordView: CustomTextField = {
        let view = CustomTextField(
            placeholder: "Введите пароль",
            labelText: "пароль"
        )
        view.textField.isSecureTextEntry = true
        return view
    }()
    
    private lazy  var passwordErrorLabel: UILabel = {
        var label = UILabel()
        label.text = "* неверный пароль"
        label.font = .montserratMedium(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.isHidden = true
        return emailLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Редактировать профиль"
        setupView()
        setConstraint()
        
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.getUserInfo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    //Button Action
    func saveButtonTap() {
        guard let inputName = nameView.textField.text, isValidName(inputName),
              let inputEmail = emailView.textField.text, isValidEmail(inputEmail),
              let inputPassword = passwordView.textField.text,
              isValidPassword(inputPassword)
        else {
            return
        }
        
        let user = createUserWith(
            name: inputName,
            email: inputEmail,
            password: inputPassword,
            avatarImage: nil
        )
        
        presenter?.updateUserInfo(user)
        presenter?.getUserInfo()
        dismiss(animated: true)
    }
    
    
    // MARK: - Private Actions
    
    func createUserWith(name: String, email: String, password: String, avatarImage: UIImage?) -> AuthModel {
        var user = AuthModel(name: name, email: email, password: password, avatar: nil)
        
        if let avatarImage = avatarImage, let avatarData = avatarImage.pngData() {
            user.avatar = avatarData
        } else if let defaultAvatar = UIImage(named: "cinemaIcon"),
                  let avatarData = defaultAvatar.pngData() {
            user.avatar = avatarData
        }
        
        return user
    }
    
    @objc private func avatarEditButtonTap() {
        alertImageView()
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
    
    private func alertError(_ error: String) {
        let alert = AlertFactory.makeErrorAlert(with: error)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - ViewProtocol
extension EditProfileViewController: EditProfileViewProtocol {
    
    func displayError(error: String) {
        alertError(error)
    }
    
    func updateProfileInfo(user: UserEntity) {
        nameLabel.text = user.userName
        emailLabel.text = user.userEmail
        avatarImageView.image = UIImage(data: user.userAvatar ?? Data())
    }
}

private extension EditProfileViewController {
    
    func setupView() {
        view.backgroundColor = .primaryDark
        
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(saveButton)
        view.addSubview(avatarEditButton)
        view.addSubview(nameView)
        view.addSubview(nameErrorLabel)
        view.addSubview(emailView)
        view.addSubview(emailErrorLabel)
        view.addSubview(passwordView)
        view.addSubview(passwordErrorLabel)
    }
    
    func setConstraint() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(avatarImageView.snp.width)
            avatarImageView.layer.cornerRadius = 60
        }
        
        avatarEditButton.snp.makeConstraints { make in
            make.bottom.equalTo(avatarImageView.snp.bottom)
                .offset(1)
            make.right.equalTo(avatarImageView.snp.right)
                .offset(5)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(21)
            make.centerX.equalTo(avatarImageView)
            make.width.equalTo(80)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.centerX.equalTo(nameLabel)
            make.width.equalTo(180)
        }
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
        //        nameErrorLabel.snp.makeConstraints { make in
        //            make.top.equalTo(nameView.snp.bottom).offset(4)
        //            make.leading.equalToSuperview().offset(30)
        //        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
        //        emailErrorLabel.snp.makeConstraints { make in
        //            make.top.equalTo(emailView.snp.bottom).offset(4)
        //            make.leading.equalToSuperview().offset(30)
        //        }
        
        passwordView.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.lessThanOrEqualToSuperview().offset(-150)
            make.height.equalTo(56)
        }
    }
}

extension EditProfileViewProtocol {
    
    var _avatarImageView: UIImageView {
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "cinemaIcon")
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .white
        return avatarImageView
    }
}