import UIKit
import PhotosUI

final class EditProfileViewController: UIViewController {
    
    enum ImageLoad: String {
        case camera = "Камера"
        case photoLibrary = "Фотогаллерея"
        case cancel = "Отмена"
    }
    
    var presenter: EditProfilePresenterProtocol?
    
    private lazy var avatarImageView: UIImageView = {
        var avatarImageView = UIImageView()
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = .white
        avatarImageView.layer.cornerRadius = 60
        return avatarImageView
    }()
    
    private lazy var avatarEditButton: UIButton = {
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
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    private lazy var nameView: CustomTextField = {
        let view = CustomTextField(placeholder: "ваше имя...", labelText: "Полное имя")
        view.textField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingDidEnd)
        view.translatesAutoresizingMaskIntoConstraints = false
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
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Редактировать профиль"
        setupView()
        setConstraint()
    }
    
    private func chooseImage(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func setAlertAction(alert: UIAlertController, imageLoad: ImageLoad) {
        let action: UIAlertAction
        
        switch imageLoad {
        case .camera:
            action = UIAlertAction(title: imageLoad.rawValue, style: .default) { _ in
                self.chooseImage(source: .camera)
            }
        case .photoLibrary:
            action = UIAlertAction(title: imageLoad.rawValue, style: .default) { _ in
                self.chooseImage(source: .photoLibrary)
            }
        case .cancel:
            action = UIAlertAction(title: imageLoad.rawValue, style: .cancel, handler: nil)
        }
        
        action.setValue(UIColor.darkGray, forKey: "titleTextColor")
        alert.addAction(action)
    }
    
    private func alertImageView() {
        let alert = UIAlertController(title: nil, message: "Выберите способ загрузки фотографии", preferredStyle: .alert)
        
        setAlertAction(alert: alert, imageLoad: .camera)
        setAlertAction(alert: alert, imageLoad: .photoLibrary)
        setAlertAction(alert: alert, imageLoad: .cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private Actions
    
    
    @objc private func saveButtonTap() {
     
    }
    
    @objc private func avatarEditButtonTap() {
        alertImageView()
    }
    
    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if isValidName(text) {
                nameView.backgroundView.layer.borderColor = UIColor.systemGray.cgColor
            } else {
                nameView.backgroundView.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            if isValidEmail(text) {
                emailView.backgroundView.layer.borderColor = UIColor.systemGray.cgColor
            } else {
                emailView.backgroundView.layer.borderColor = UIColor.red.cgColor
            }
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
}

// MARK: - Protocols for load Image from gallery
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarImageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: EditProfileViewProtocol {
    
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
    }
    
    func setConstraint() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(avatarImageView.snp.width)
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
        
//        nameErrorLabel.snp.makeConstraints { make in
//            make.top.equalTo(nameView.snp.bottom).offset(4)
//          //  make.leading.equalToSuperview().offset(30)
//        }
        
        emailView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(58)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
//        emailErrorLabel.snp.makeConstraints { make in
//            make.top.equalTo(emailView.snp.bottom).offset(4)
//            make.leading.equalToSuperview().offset(30)
//        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-120)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(56)
        }
    }
}
