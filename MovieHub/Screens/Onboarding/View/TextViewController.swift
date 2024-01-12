//
//  TextViewController.swift
//  MovieHub
//
//  Created by Dmitrii Dorogov on 11.01.2024.
//

import UIKit

class TextViewController: UIViewController {
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "NextButton1.png"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(TextViewController.self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let label: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor(red: 23/255, green: 24/255, blue: 36/255, alpha: 1)
        view.textColor = .white
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
     let welcomeImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "welcomeImage")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
//    init(with text: String) {
//        self.myText = text
//        myTextView.text = self.myText
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(imageName: String, titleText: String, buttonImage: String) {
            super.init(nibName: nil, bundle: nil)
            welcomeImage.image = UIImage(named: imageName)
            label.text = titleText
            nextButton.setImage(UIImage(named: buttonImage), for: .normal)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.welcomeImage)
        view.addSubview(self.label)
        view.addSubview(self.nextButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 23/255, green: 24/255, blue: 36/255, alpha: 1)
    
            nextButton.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(45)
                make.bottom.equalToSuperview().inset(80)
                make.height.width.equalTo(60)
            }
    
            label.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(nextButton).inset(70)
                make.height.equalTo(100)
            }
    
            welcomeImage.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(label).inset(120)
                make.top.equalToSuperview()
            }
        }
    
    @objc private func nextButtonPressed() {
        
        let homeVC = Builder.createTabBar()
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        present(homeVC, animated: true)
    }
    
//    @objc func nextTapped(_ sender: UIButton) {
//        pageControl.currentPage += 1
//        goToNextPage()
//     //   animateControlsIfNeeded()
//    }
//    
//    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
//        guard let currentPage = viewControllers?[0] else { return }
//        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
//        
//        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
//    }
}
