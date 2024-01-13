import UIKit

final class ProfileViewController: UIViewController {
    
    //MARK: Constants
    enum Constants {
        static let generalViewMainText = "General"
        static let moreViewMainText = "More"
        static let notificationLabelText = "Notification"
        static let languageLabelText = "Language"
        static let offertaLabelText = "Legal and Policies"
        static let aboutUsText = "About Us"
        
        static let cornerRadiusForViews: CGFloat = 16
        static let borderWidhtForViews: CGFloat = 0.5
        
        static let profileStackViewTopInset: CGFloat = 24
        static let profileStackViewLeadingInset: CGFloat = 24
        static let profileStackViewTrailingInset: CGFloat = 24
        static let profileStackViewHeight: CGFloat = 86
        
        static let generalViewLeadingInset: CGFloat = 38
        static let generalViewTrailingInset: CGFloat = 18.5
        
        static let moreViewTopInset: CGFloat = 13.87
        static let moreViewLeadingInset: CGFloat = 33.5
        static let moreViewTrailingInset: CGFloat = 14.5
        
        static let avatarImageViewTopInset: CGFloat = 15
        static let avatarImageViewBottomInset: CGFloat = 15
        static let avatarImageViewLeadingInset: CGFloat = 15
        
        static let nameAndEmailStackViewTopInset: CGFloat = 15
        static let nameAndEmailStackViewBottomInset: CGFloat = 15
        static let nameAndEmailStackViewLeadingInset: CGFloat = 18
        static let nameAndEmailStackViewTrailingInset: CGFloat = 18
        
        static let generalLabelTopInset: CGFloat = 22.62
        static let generalLabelLeadingInset: CGFloat = 9.5
        
        static let notificationImageViewTopInset: CGFloat = 27
        static let notificationImageViewLeadingInset: CGFloat = 13
        
        static let notificationLabelInset: CGFloat = 20
        
        static let languageImageViewTopInset: CGFloat = 47
        
        static let moreLabelTopInset: CGFloat = 15
        static let moreLabelLeadingInset: CGFloat = 15
        
        static let policyImageViewTopInset: CGFloat = 27
    }
    
    //MARK: Profile view and his subviews
    private lazy var profileView: UIView = {
        var profileView = UIView()
        profileView.layer.borderColor = UIColor.systemGray.cgColor
        profileView.layer.borderWidth = Constants.borderWidhtForViews
        profileView.layer.cornerRadius = Constants.cornerRadiusForViews
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    private lazy var nameAndEmailStackView: UIStackView = {
        var nameAndEmailStackView = UIStackView()
        nameAndEmailStackView.axis = .vertical
        nameAndEmailStackView.spacing = 8
        nameAndEmailStackView.translatesAutoresizingMaskIntoConstraints = false
        return nameAndEmailStackView
    }()
    
    private lazy var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.font = .montserratSemiBold(size: 20)
        nameLabel.textColor = .white
        nameLabel.text = "Tiffany"
        return nameLabel
    }()
    
    private lazy var emailLabel: UILabel = {
        var emailLabel = UILabel()
        emailLabel.font = .montserratMedium(size: 17)
        emailLabel.text = "tiffany@gmail.com"
        emailLabel.textColor = .systemGray
        return emailLabel
    }()
    
    private lazy var avatarImageView: UIImageView = {
        var avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.clipsToBounds = true 
        avatarImageView.backgroundColor = .white
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private lazy var editProfileButtom: UIButton = {
        var editProfileButton = UIButton()
        editProfileButton.setImage(UIImage(systemName: "pencil.line"), for: .normal)
        editProfileButton.tintColor = .white
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        editProfileButton.addTarget(self, action: #selector(editProfileAction), for: .touchUpInside)
        return editProfileButton
    }()
    
    //MARK: General view and his subviews
    private lazy var generalView: UIView = {
        var generalView = UIView()
        generalView.layer.borderColor = UIColor.systemGray.cgColor
        generalView.layer.cornerRadius = Constants.cornerRadiusForViews
        generalView.layer.borderWidth = Constants.borderWidhtForViews
        generalView.translatesAutoresizingMaskIntoConstraints = false
        return generalView
    }()
    
    private lazy var generalLabel: UILabel = {
        var generalLabel = UILabel()
        generalLabel.font = .montserratSemiBold(size: 22)
        generalLabel.text = Constants.generalViewMainText
        generalLabel.textColor = .white
        generalLabel.translatesAutoresizingMaskIntoConstraints = false 
        return generalLabel
    }()
    
    private lazy var notificationImageView: UIImageView = {
        var notificationImageView = UIImageView()
        notificationImageView.translatesAutoresizingMaskIntoConstraints = false
        notificationImageView.image = UIImage(systemName: "bell")
        notificationImageView.tintColor = .gray
        return notificationImageView
    }()
    
    private lazy var notificationLabel: UILabel = {
        var notificationLabel = UILabel()
        notificationLabel.font = .montserratMedium(size: 17)
        notificationLabel.textColor = .white
        notificationLabel.text = Constants.notificationLabelText
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        return notificationLabel
    }()
    
    private lazy var notificationButton: UIButton = {
        var notificationButton = UIButton()
        notificationButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        notificationButton.tintColor = .white
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        return notificationButton
    }()
    
    private lazy var languageImageView: UIImageView = {
        var languageImageView = UIImageView()
        languageImageView.translatesAutoresizingMaskIntoConstraints = false
        languageImageView.image = UIImage(systemName: "globe")
        languageImageView.tintColor = .gray
        return languageImageView
    }()
    
    private lazy var languageLabel: UILabel = {
        var languageLabel = UILabel()
        languageLabel.font = .montserratMedium(size: 17)
        languageLabel.textColor = .white
        languageLabel.text = Constants.languageLabelText
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        return languageLabel
    }()
    
    private lazy var languageButton: UIButton = {
        var languageButton = UIButton()
        languageButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        languageButton.tintColor = .white
        languageButton.translatesAutoresizingMaskIntoConstraints = false
        return languageButton
    }()
    
    //MARK: More view and his subviews
    private lazy var moreView: UIView = {
        var moreView = UIView()
        moreView.layer.borderColor = UIColor.systemGray.cgColor
        moreView.layer.cornerRadius = Constants.cornerRadiusForViews
        moreView.layer.borderWidth = Constants.borderWidhtForViews
        moreView.translatesAutoresizingMaskIntoConstraints = false
        return moreView
    }()
    
    private lazy var moreLabel: UILabel = {
        var moreLabel = UILabel()
        moreLabel.font = .montserratSemiBold(size: 22)
        moreLabel.text = Constants.moreViewMainText
        moreLabel.textColor = .white
        moreLabel.translatesAutoresizingMaskIntoConstraints = false
        return moreLabel
    }()
    
    private lazy var policyImageView: UIImageView = {
        var policyImageView = UIImageView()
        policyImageView.translatesAutoresizingMaskIntoConstraints = false
        policyImageView.image = UIImage(systemName: "shield.fill")
        policyImageView.tintColor = .gray
        return policyImageView
    }()
    
    private lazy var policyLabel: UILabel = {
        var policyLabel = UILabel()
        policyLabel.font = .montserratMedium(size: 17)
        policyLabel.textColor = .white
        policyLabel.text = Constants.offertaLabelText
        policyLabel.translatesAutoresizingMaskIntoConstraints = false
        return policyLabel
    }()
    
    private lazy var policyButton: UIButton = {
        var policyButton = UIButton()
        policyButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        policyButton.tintColor = .white
        policyButton.addTarget(self, action: #selector(policyButtonTap), for: .touchUpInside)
        policyButton.translatesAutoresizingMaskIntoConstraints = false
        return policyButton
    }()
    
    private lazy var infoImageView: UIImageView = {
        var infoImageView = UIImageView()
        infoImageView.translatesAutoresizingMaskIntoConstraints = false
        infoImageView.image = UIImage(systemName: "info.circle.fill")
        infoImageView.tintColor = .gray
        return infoImageView
    }()
    
    private lazy var infoLabel: UILabel = {
        var infoLabel = UILabel()
        infoLabel.font = .montserratMedium(size: 17)
        infoLabel.textColor = .white
        infoLabel.text = Constants.aboutUsText
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        return infoLabel
    }()
    
    private lazy var infoButton: UIButton = {
        var infoButton = UIButton()
        infoButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        infoButton.tintColor = .white
        infoButton.addTarget(self, action: #selector(aboutUsButtonTap), for: .touchUpInside)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        return infoButton
    }()
    
    var presenter: ProfilePresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    @objc private func policyButtonTap() {
        presenter?.routeToPolicies()
    }
    
    @objc private func aboutUsButtonTap() {
        presenter?.routeToAboutUs()
    }
}


//MARK: - Extension ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    
    
}

private extension ProfileViewController {
    
    func drawSelf() {
        view.backgroundColor = .primarySoft
        view.addAllViews(profileView, 
                         generalView,
                         moreView)
        profileView.addAllViews(avatarImageView, 
                                nameAndEmailStackView,
                                editProfileButtom)
        
        nameAndEmailStackView.addArrangedSubview(nameLabel)
        nameAndEmailStackView.addArrangedSubview(emailLabel)
        
        generalView.addAllViews(generalLabel,
                                notificationImageView,
                                notificationLabel, 
                                notificationButton,
                                languageImageView,
                                languageLabel,
                                languageButton)
        
        moreView.addAllViews(moreLabel, 
                             policyImageView,
                             policyLabel,
                             policyButton,
                             infoImageView,
                             infoLabel, 
                             infoButton)
        
        let profileStackViewConstraints = self.setProfileStackViewConstraints()
        let generalViewConstraints = self.setGeneralViewConstraints()
        let moreViewConstraints = self.setMoreViewConstraints()
        let avatarImageViewConstraints = self.setAvatarImageView()
        let nameAndEmailConstraints = self.setNameAndEmailStackViewConstraints()
        let ediProfileButtonConstraints = self.setEditProfileButtonConstraints()
        let generalLabelConstraints = self.setGeneralLabelConstraints()
        let notificationImageViewConstraint = self.setNotificationImageViewConstraints()
        let notificationLabelConstraints = self.setNotificationLabelConstraints()
        let notificationButtonConstraints = self.setNotificationButtonConstraints()
        let languageImageViewConstraints = self.setLanguageImageViewConstraints()
        let languageLabelConstraints = self.setLanguageLabelConstraints()
        let languageButtonConstraints = self.setLanguageButtonConstraints()
        let moreLabelConstraints = self.setMoreLabelConstraints()
        let policyImageViewConstraints = self.setPolicyImageViewConstraints()
        let policyLabelConstraints = self.setPolicyLabelConstraints()
        let policyButtonConstraints = self.setPolicyButtonConstraints()
        let infoImageViewConstraints = self.setInfoImageViewConstraints()
        let infoLabelConstraints = self.setInfoLabelConstraints()
        let infoButtonConstraints = self.setInfoButtonConstraints()
        
        NSLayoutConstraint.activate(profileStackViewConstraints +
                                    generalViewConstraints +
                                    moreViewConstraints +
                                    avatarImageViewConstraints +
                                    nameAndEmailConstraints +
                                    ediProfileButtonConstraints +
                                    generalLabelConstraints +
                                    notificationImageViewConstraint +
                                    notificationLabelConstraints +
                                    notificationButtonConstraints +
                                    languageImageViewConstraints + 
                                    languageLabelConstraints +
                                    languageButtonConstraints + 
                                    moreLabelConstraints +
                                    policyImageViewConstraints +
                                    policyLabelConstraints +
                                    policyButtonConstraints +
                                    infoImageViewConstraints +
                                    infoLabelConstraints +
                                    infoButtonConstraints)
    }
    
    func setProfileStackViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.profileStackViewTopInset)
        let leadingAnchor = profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.profileStackViewLeadingInset)
        let trailingAnchor = profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.profileStackViewTrailingInset)
        let heightAnchor = profileView.heightAnchor.constraint(equalToConstant: Constants.profileStackViewHeight)
        return [topAnchor, leadingAnchor, trailingAnchor, heightAnchor]
    }
    
    func setGeneralViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = generalView.topAnchor.constraint(equalTo: profileView.bottomAnchor)
        let leadingAnchor = generalView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.generalViewLeadingInset)
        let trailingAnchor = generalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.generalViewTrailingInset)
        let heightAnchor = generalView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4)
        return [topAnchor, leadingAnchor, trailingAnchor, heightAnchor]
    }
    
    func setMoreViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = moreView.topAnchor.constraint(equalTo: generalView.bottomAnchor, constant: Constants.moreViewTopInset)
        let leadingAnchor = moreView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.moreViewLeadingInset)
        let trailingAnchor = moreView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.moreViewTrailingInset)
        let heightAnchor = moreView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22)
        return [topAnchor, leadingAnchor, trailingAnchor, heightAnchor]
    }
    
    func setAvatarImageView() -> [NSLayoutConstraint] {
        let topAnchor = avatarImageView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: Constants.avatarImageViewTopInset)
        let leadingAnchor = avatarImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: Constants.avatarImageViewLeadingInset)
        let bottomAnchor = avatarImageView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -Constants.avatarImageViewBottomInset)
        let widhtAnchor = avatarImageView.widthAnchor.constraint(equalToConstant: 54)
        return [topAnchor, leadingAnchor, bottomAnchor, widhtAnchor]
    }
    
    func setNameAndEmailStackViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = nameAndEmailStackView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: Constants.nameAndEmailStackViewTopInset)
        let leadingAnchor = nameAndEmailStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.nameAndEmailStackViewLeadingInset)
        let bottomAnchor = nameAndEmailStackView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -Constants.nameAndEmailStackViewBottomInset)
        let trailingAnchor = nameAndEmailStackView.trailingAnchor.constraint(equalTo: editProfileButtom.leadingAnchor, constant: -Constants.nameAndEmailStackViewTrailingInset)
        return [topAnchor, leadingAnchor, bottomAnchor, trailingAnchor]
    }
    
    func setEditProfileButtonConstraints() -> [NSLayoutConstraint] {
        let topAnchor = editProfileButtom.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 20)
        let leadingAnchor = editProfileButtom.leadingAnchor.constraint(equalTo: nameAndEmailStackView.trailingAnchor, constant: 18)
        let bottomAnchor = editProfileButtom.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -20)
        let trailingAnchor = editProfileButtom.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -19)
        return [topAnchor, leadingAnchor, bottomAnchor, trailingAnchor]
    }
    
    func setGeneralLabelConstraints() -> [NSLayoutConstraint] {
        let topAnchor = generalLabel.topAnchor.constraint(equalTo: generalView.topAnchor, constant: Constants.generalLabelTopInset)
        let leadingAnchor = generalLabel.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: Constants.generalLabelLeadingInset)
        return [topAnchor, leadingAnchor]
    }
    
    func setNotificationImageViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = notificationImageView.topAnchor.constraint(equalTo: generalLabel.bottomAnchor, constant: Constants.notificationImageViewTopInset)
        let leadingAnchor = notificationImageView.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: Constants.notificationImageViewLeadingInset)
        let heightAnchor = notificationImageView.heightAnchor.constraint(equalToConstant: 24)
        let widthAnchor = notificationImageView.widthAnchor.constraint(equalTo: notificationImageView.heightAnchor)
        return [topAnchor, leadingAnchor, heightAnchor, widthAnchor]
    }
    
    func setNotificationLabelConstraints() -> [NSLayoutConstraint] {
        let centerYAnchor = notificationLabel.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor)
        let leadingAnchor = notificationLabel.leadingAnchor.constraint(equalTo: notificationImageView.trailingAnchor, constant: Constants.notificationLabelInset)
        return [centerYAnchor, leadingAnchor]
    }
    
    func setNotificationButtonConstraints() -> [NSLayoutConstraint] {
        let centerYAnchor = notificationButton.centerYAnchor.constraint(equalTo: notificationImageView.centerYAnchor)
        let trailingAnchor = notificationButton.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -19)
        return [centerYAnchor, trailingAnchor]
    }
    
    func setLanguageImageViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = languageImageView.topAnchor.constraint(equalTo: notificationImageView.bottomAnchor, constant: Constants.languageImageViewTopInset)
        let leadingAnchor = languageImageView.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: Constants.notificationImageViewLeadingInset)
        let heightAnchor = languageImageView.heightAnchor.constraint(equalToConstant: 24)
        let widthAnchor = languageImageView.widthAnchor.constraint(equalTo: languageImageView.heightAnchor)
        return [topAnchor, leadingAnchor, heightAnchor, widthAnchor]
    }
    
    func setLanguageLabelConstraints() -> [NSLayoutConstraint] {
        let centerYAnchor = languageLabel.centerYAnchor.constraint(equalTo: languageImageView.centerYAnchor)
        let leadingAnchor = languageLabel.leadingAnchor.constraint(equalTo: languageImageView.trailingAnchor, constant: Constants.notificationLabelInset)
        return [centerYAnchor, leadingAnchor]
    }
    
    func setLanguageButtonConstraints() -> [NSLayoutConstraint] {
        let centerYAnchor = languageButton.centerYAnchor.constraint(equalTo: languageImageView.centerYAnchor)
        let trailingAnchor = languageButton.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -19)
        return [centerYAnchor, trailingAnchor]
    }
    
    func setMoreLabelConstraints() -> [NSLayoutConstraint] {
        let topAnchor = moreLabel.topAnchor.constraint(equalTo: moreView.topAnchor, constant: Constants.moreLabelTopInset)
        let leadingAnchor = moreLabel.leadingAnchor.constraint(equalTo: moreView.leadingAnchor, constant: Constants.moreLabelLeadingInset)
        return [topAnchor, leadingAnchor]
    }
    
    func setPolicyImageViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = policyImageView.topAnchor.constraint(equalTo: moreLabel.bottomAnchor, constant: Constants.policyImageViewTopInset)
        let leadingAnchor = policyImageView.leadingAnchor.constraint(equalTo: moreView.leadingAnchor, constant: 15)
        let heightAnchor = policyImageView.heightAnchor.constraint(equalToConstant: 24)
        let widthAnchor = policyImageView.widthAnchor.constraint(equalTo: policyImageView.heightAnchor)
        return [topAnchor, leadingAnchor, heightAnchor, widthAnchor]
    }
    
    func setPolicyLabelConstraints() -> [NSLayoutConstraint] {
        let centerYAnchor = policyLabel.centerYAnchor.constraint(equalTo: policyImageView.centerYAnchor)
        let leadingAnchor = policyLabel.leadingAnchor.constraint(equalTo: policyImageView.trailingAnchor, constant: Constants.notificationLabelInset)
        return [centerYAnchor, leadingAnchor]
    }
    
    func setPolicyButtonConstraints() -> [NSLayoutConstraint] {
        let centerYAnchor = policyButton.centerYAnchor.constraint(equalTo: policyImageView.centerYAnchor)
        let trailingAnchor = policyButton.trailingAnchor.constraint(equalTo: moreView.trailingAnchor, constant: -19)
        return [centerYAnchor, trailingAnchor]
    }
    
    func setInfoImageViewConstraints() -> [NSLayoutConstraint] {
        let topAnchor = infoImageView.topAnchor.constraint(equalTo: policyImageView.bottomAnchor, constant: Constants.languageImageViewTopInset)
        let leadingAnchor = infoImageView.leadingAnchor.constraint(equalTo: moreView.leadingAnchor, constant: Constants.notificationImageViewLeadingInset)
        let heightAnchor = infoImageView.heightAnchor.constraint(equalToConstant: 24)
        let widthAnchor = infoImageView.widthAnchor.constraint(equalTo: infoImageView.heightAnchor)
        return [topAnchor, leadingAnchor, heightAnchor, widthAnchor]
    }
    
    func setInfoLabelConstraints() -> [NSLayoutConstraint] {
        let centerYAnchor = infoLabel.centerYAnchor.constraint(equalTo: infoImageView.centerYAnchor)
        let leadingAnchor = infoLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: Constants.notificationLabelInset)
        return [centerYAnchor, leadingAnchor]
    }
    
    func setInfoButtonConstraints() -> [NSLayoutConstraint] {
        let centerYAnchor = infoButton.centerYAnchor.constraint(equalTo: infoImageView.centerYAnchor)
        let trailingAnchor = infoButton.trailingAnchor.constraint(equalTo: moreView.trailingAnchor, constant: -19)
        return [centerYAnchor, trailingAnchor]
    }
    
    @objc func editProfileAction() {
        presenter?.routeToEditProfile()
    }
}
