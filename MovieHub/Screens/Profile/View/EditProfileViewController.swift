import UIKit

final class EditProfileViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        var avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .white
        avatarImageView.layer.cornerRadius = 60
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
    
    private lazy var nameView: CustomTextField = {
        let view = CustomTextField(placeholder: "ваше имя...", labelText: "Полное имя")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailView: CustomTextField = {
        let view = CustomTextField(placeholder: "ваш email...", labelText: "Email")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Редактировать профиль"
        setupView()
        setConstraint()
    }
    
    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if isValidName(text) {
                nameView.backgroundView.layer.borderColor = UIColor.systemGray.cgColor
            } else {
                nameView.backgroundView.layer.borderWidth = 1
                nameView.backgroundView.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if isValidEmail(text) {
                emailView.backgroundView.layer.borderColor = UIColor.systemGray.cgColor
            } else {
                nameView.backgroundView.layer.borderWidth = 1
                emailView.backgroundView.layer.borderColor = UIColor.red.cgColor
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
    
    func setupView() {
        view.backgroundColor = .primaryDark
        
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(saveButton)
        
        view.addSubview(nameView)
        view.addSubview(emailView)
    }
    
    func setConstraint() {
        
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
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
        
        nameView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
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
