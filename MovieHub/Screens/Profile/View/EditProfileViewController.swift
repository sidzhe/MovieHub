import UIKit

final class EditProfileViewController: UIViewController {
    
    private lazy var avatarImageView: UIImageView = {
        var avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .white
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
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
        saveButton.layer.cornerRadius = 32
        saveButton.backgroundColor = .primaryBlue
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    private lazy var nameTextField: UITextField = {
        var nameTextField = UITextField()
        nameTextField.layer.cornerRadius = 24
        nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.layer.borderWidth = 0.5
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        return nameTextField
    }()
    
    private lazy var emailTextField: UITextField = {
        var emailTextField = UITextField()
        emailTextField.layer.cornerRadius = 24
        emailTextField.layer.borderColor = UIColor.systemGray.cgColor
        emailTextField.layer.borderWidth = 0.5
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }

}

private extension EditProfileViewController {
    
    func drawSelf() {
        view.backgroundColor = .primarySoft
        view.addAllViews(avatarImageView, nameLabel, emailLabel, nameTextField, emailTextField, saveButton)
        let avatarImageViewConstraints = self.setAvatarImageViewConstraints()
        let nameLabelConstraints = self.setNameLabelConstraints()
        let emailLabelConstraints = self.setEmailLabelConstraint()
        let nameTextFieldConstraints = self.setNameTextFieldConstraints()
        let emailTextFieldConstraints = self.setEmailTextFieldConstraints()
        let saveButtonConstraints = self.setSaveButtomConstraints()
        NSLayoutConstraint.activate(avatarImageViewConstraints +
                                    nameLabelConstraints +
                                    emailLabelConstraints +
                                    nameTextFieldConstraints +
                                    emailTextFieldConstraints +
                                    saveButtonConstraints)
    }
    
    func setAvatarImageViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
        let centerXAncor = avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let widthAnchor = avatarImageView.widthAnchor.constraint(equalToConstant: 64)
        let heightAnchor = avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        return [topAnchor, centerXAncor, widthAnchor, heightAnchor]
    }
    
    func setNameLabelConstraints() -> [NSLayoutConstraint] {
        let topAnchor = nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 21)
        let centerXAnchor = nameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor)
        return [topAnchor, centerXAnchor]
    }
    
    func setEmailLabelConstraint() -> [NSLayoutConstraint] {
        let topAnchor = emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8)
        let centerXAnchor = emailLabel.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor)
        return [topAnchor, centerXAnchor]
    }
    
    func setNameTextFieldConstraints() -> [NSLayoutConstraint] {
        let topAnchor = nameTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 48)
        let leadingAnchor = nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        let trailingAnchor = nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        let heightAnchor = nameTextField.heightAnchor.constraint(equalToConstant: 53)
        return [topAnchor, leadingAnchor, trailingAnchor, heightAnchor]
    }
    
    func setEmailTextFieldConstraints() -> [NSLayoutConstraint] {
        let topAnchor = emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 55)
        let leadingAnchor = emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        let trailingAnchor = emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        let heightAnchor = emailTextField.heightAnchor.constraint(equalToConstant: 53)
        return [topAnchor, leadingAnchor, trailingAnchor, heightAnchor]
    }
    
    func setSaveButtomConstraints() -> [NSLayoutConstraint] {
        let topAnchor = saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75)
        let leadingAnchor = saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        let trailingAnchor = saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        let heightAnchor = saveButton.heightAnchor.constraint(equalToConstant: 56)
        return [topAnchor, leadingAnchor, trailingAnchor, heightAnchor]
    }
}
