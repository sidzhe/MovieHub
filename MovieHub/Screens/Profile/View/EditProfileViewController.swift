import UIKit

final class EditProfileViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        var avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .white
        avatarImageView.layer.cornerRadius = 32
        return avatarImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Tiffany"
        nameLabel.font = .montserratSemiBold(size: 20)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    private lazy var emailLabel: UILabel = {
        var emailLabel = UILabel()
        emailLabel.text = "tiffany@gmail.com"
        emailLabel.font = .montserratMedium(size: 17)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = .gray
        return emailLabel
    }()
    
    private lazy var saveButton: UIButton = {
        var saveButton = UIButton()
        saveButton.setTitle("Save changes", for: .normal)
        saveButton.titleLabel?.font = .montserratMedium(size: 20)
        saveButton.layer.cornerRadius = 27
        saveButton.backgroundColor = .primaryBlue
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    private lazy var nameBackgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailBackgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        var nameTextField = UITextField()
        nameTextField.placeholder = "ваше имя..."
        nameTextField.textColor = .white
        nameTextField.autocorrectionType = .no
        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange(_:)), for: .editingChanged)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    
    private lazy var emailTextField: UITextField = {
        var emailTextField = UITextField()
        emailTextField.placeholder = "ваш email..."
        emailTextField.textColor = .white
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()
    
    private lazy var infoNameLabel: UILabel = {
        var emailLabel = UILabel()
        emailLabel.text = "Полное имя"
        emailLabel.font = .montserratMedium(size: 13)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = .white
        emailLabel.textAlignment = .center
        emailLabel.backgroundColor = .primaryDark
        emailLabel.adjustsFontSizeToFitWidth = true
        return emailLabel
    }()
    
    private lazy var infoMailLabel: UILabel = {
        var emailLabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.font = .montserratMedium(size: 13)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.textColor = .white
        emailLabel.textAlignment = .center
        emailLabel.backgroundColor = .primaryDark
        emailLabel.adjustsFontSizeToFitWidth = true
        return emailLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Редактировать профиль"
        drawSelf()
    }
    
    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if isValidName(text) {
                nameBackgroundView.layer.borderColor = UIColor.systemGray.cgColor
            } else {
                nameBackgroundView.layer.borderColor = UIColor.red.cgColor
            }
        }
    }

    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if isValidEmail(text) {
                emailBackgroundView.layer.borderColor = UIColor.systemGray.cgColor
            } else {
                emailBackgroundView.layer.borderColor = UIColor.red.cgColor
            }
        }
    }

    private func isValidName(_ name: String) -> Bool {
        guard !name.isEmpty else {
            return false
        }
        let alphanumericSet = CharacterSet.alphanumerics
        return name.rangeOfCharacter(from: alphanumericSet.inverted) == nil
    }

    private func isValidEmail(_ email: String) -> Bool {
        guard !email.isEmpty else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

private extension EditProfileViewController {
    
    func drawSelf() {
        view.backgroundColor = .primaryDark
        
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(saveButton)
        view.addSubview(nameBackgroundView)
        view.addSubview(emailBackgroundView)
        
        nameBackgroundView.addSubview(nameTextField)
        nameBackgroundView.addSubview(infoNameLabel)
        
        emailBackgroundView.addSubview(emailTextField)
        emailBackgroundView.addSubview(infoMailLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(avatarImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(21)
            make.centerX.equalTo(avatarImageView)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.centerX.equalTo(nameLabel)
        }
        
        nameBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
        infoNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(-27)
            make.width.equalTo(80)
        }
        
        infoMailLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview().offset(-27)
            make.width.equalTo(80)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
        emailBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(nameBackgroundView.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-48)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-120)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
    }
}
