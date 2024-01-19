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
        navigationController?.setupNavigationBar()
    }
    
    func addTargetForButtons() {
      generalView.addTargetForFirstButton(target: self, action: #selector(policyButtonTap), for: .touchUpInside)
      generalView.addTargetForSecondButton(target: self, action: #selector(aboutUsButtonTap), for: .touchUpInside)

      moreView.addTargetForFirstButton(target: self, action: #selector(policyButtonTap), for: .touchUpInside)
      moreView.addTargetForSecondButton(target: self, action: #selector(aboutUsButtonTap), for: .touchUpInside)
    }
    
    private func setupView() {
        navigationItem.title = "Профиль"
        view.backgroundColor = .primaryDark
        view.addSubview(profileView)
        view.addSubview(generalView)
        view.addSubview(moreView)
    }
    
    private  func setupConstraints() {
        profileView.snp.makeConstraints { make in
            make.top.equalTo(130)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(86)
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
    
    //MARK: - Objective-C methods
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
