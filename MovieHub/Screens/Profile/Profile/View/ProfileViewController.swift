import UIKit

final class ProfileViewController: UIViewController {
    var presenter: ProfilePresenterProtocol?
    
    private lazy var profileView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        view.layer.borderWidth = 0.8
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "git")
        img.layer.cornerRadius = 27
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Tiffany"
        label.font = UIFont.montserratSemiBold(size: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.text = "Tiffanyjearsey@gmail.com"
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "avatarEditButton"), for: .normal)
        button.addTarget(self, action: #selector(editProfileAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var generalView = GeneralView(
        labelText: "Настройки",
        firstButtonTitle: "Уведомления",
        firstImage: "notif",
        secondButtonTitle: "Выбор языка",
        secondImage: "lang"
    )
    
    private lazy var moreView = GeneralView(
        labelText: "Информация",
        firstButtonTitle: "Правила",
        firstImage: "legal",
        secondButtonTitle: "О нас",
        secondImage: "about"
    )
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        addTargetForButtons()
        
        presenter?.getUserInfo()
        navigationController?.setupNavigationBar()
        navigationItem.title = "Профиль"
    }
    
    func addTargetForButtons() {
      generalView.addTargetForFirstButton(target: self, action: #selector(notificationButtonTap), for: .touchUpInside)
      generalView.addTargetForSecondButton(target: self, action: #selector(languageButtonTap), for: .touchUpInside)

      moreView.addTargetForFirstButton(target: self, action: #selector(policyButtonTap), for: .touchUpInside)
      moreView.addTargetForSecondButton(target: self, action: #selector(aboutUsButtonTap), for: .touchUpInside)
    }
    
    private func setupView() {
       
        view.backgroundColor = .primaryDark
        
        view.addSubview(profileView)
        
        profileView.addSubview(avatarImageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(emailLabel)
        profileView.addSubview(editProfileButton)
        
        view.addSubview(generalView)
        view.addSubview(moreView)
    }
    
    private  func setupConstraints() {
        profileView.snp.makeConstraints { make in
            make.top.equalTo(130)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(86)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.height.width.equalTo(54)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.top).offset(21)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalTo(editProfileButton).offset(8)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalTo(editProfileButton).offset(8)
            make.bottom.equalToSuperview().inset(20)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview().inset(16)
            make.height.width.equalTo(54)
        }
        
        generalView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        moreView.snp.makeConstraints { make in
            make.top.equalTo(generalView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func updateProfileInfo(user: UserModel) {
        nameLabel.text = user.userName
        emailLabel.text = user.userEmail
        avatarImageView.image = UIImage(data: user.userAvatar ?? Data())
    }
    
    
    //MARK: - Objective-C methods
    @objc private func languageButtonTap() {
        presenter?.routeToLanguage()
    }
    
    @objc private func notificationButtonTap() {
        presenter?.routeToNotification()
    }
    
    @objc private func policyButtonTap() {
        presenter?.routeToPolicies()
    }
    
    @objc private func aboutUsButtonTap() {
        presenter?.routeToAboutUs()
    }
    
    @objc func editProfileAction() {
        presenter?.routeToEditProfile()
    }
}
