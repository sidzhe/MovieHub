//
//  ChristmasViewController.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit
import SnapKit

final class ChristmasViewController: UIViewController {
    
    //MARK: Properties
    var presenter: ChristmasPresenterProtocol?
    private var timer: Timer?
    private var boomTimer: Timer?
    private let tapGesture = UITapGestureRecognizer()
    
    //MARK: - UI Elements
    private var movieView: MovieView?
    private let backgroungImage = UIImageView()
    private let elkaImage = UIImageView(image: .tree)
    
    private let yellowBallImage1 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage2 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage3 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage4 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage5 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage6 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage7 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage8 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage9 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage10 = BallView(ballImage: Constant.yellowBall)
    private let yellowBallImage11 = BallView(ballImage: Constant.yellowBall)
    
    private let greenBallImage1 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage2 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage3 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage4 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage5 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage6 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage7 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage8 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage9 = BallView(ballImage: Constant.greenBall)
    private let greenBallImage10 = BallView(ballImage: Constant.greenBall)
    
    private lazy var closeMovieViewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constant.xmarkCircleFill), for: .normal)
        button.tintColor = .primaryBlue
        button.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: ViewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
        timer = nil
        backgroungImage.image = nil
        movieView?.removeFromSuperview()
        movieView = nil
        closeMovieViewButton.alpha = 0.0
        
    }
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetchRequest()
        setupGesture()
        setupViews()
        
    }
    
    //MARK: Setup UI
    private func setupViews() {
        elkaImage.isUserInteractionEnabled = true
        
        view.backgroundColor = .primaryDark
        elkaImage.backgroundColor = .clear
        
        elkaImage.addSubview(greenBallImage1)
        elkaImage.addSubview(greenBallImage2)
        elkaImage.addSubview(greenBallImage3)
        elkaImage.addSubview(greenBallImage4)
        elkaImage.addSubview(greenBallImage5)
        elkaImage.addSubview(greenBallImage6)
        elkaImage.addSubview(greenBallImage7)
        elkaImage.addSubview(greenBallImage8)
        elkaImage.addSubview(greenBallImage9)
        elkaImage.addSubview(greenBallImage10)
        
        elkaImage.addSubview(yellowBallImage1)
        elkaImage.addSubview(yellowBallImage2)
        elkaImage.addSubview(yellowBallImage3)
        elkaImage.addSubview(yellowBallImage4)
        elkaImage.addSubview(yellowBallImage5)
        elkaImage.addSubview(yellowBallImage6)
        elkaImage.addSubview(yellowBallImage7)
        elkaImage.addSubview(yellowBallImage8)
        elkaImage.addSubview(yellowBallImage9)
        elkaImage.addSubview(yellowBallImage10)
        elkaImage.addSubview(yellowBallImage11)
        
        view.addSubview(backgroungImage)
        view.addSubview(elkaImage)
        
        backgroungImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        elkaImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.bottom.equalToSuperview().inset(90)
        }
        
        greenBallImage1.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 18)
            make.left.equalToSuperview().inset(view.frame.width / 10)
        }
        
        greenBallImage2.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 12)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        yellowBallImage1.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 18)
            make.right.equalToSuperview().inset(view.frame.width / 10)
        }
        
        yellowBallImage2.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 8)
            make.left.equalToSuperview().inset(view.frame.width / 4)
        }
        
        greenBallImage3.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 8)
            make.right.equalToSuperview().inset(view.frame.width / 4)
        }
        
        yellowBallImage3.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 5)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        greenBallImage4.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 6.5)
            make.left.equalToSuperview().inset(view.frame.width / 10)
        }
        
        yellowBallImage4.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 6)
            make.right.equalToSuperview().inset(view.frame.width / 10)
        }
        
        greenBallImage5.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 4.4)
            make.right.equalToSuperview().inset(view.frame.width / 4)
        }
        
        yellowBallImage5.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 4.4)
            make.left.equalToSuperview().inset(view.frame.width / 4)
        }
        
        greenBallImage6.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 3.5)
            make.right.equalToSuperview().inset(view.frame.width / 3)
        }
        
        yellowBallImage6.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 3.5)
            make.left.equalToSuperview().inset(view.frame.width / 3)
        }
        
        yellowBallImage7.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 2.9)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        greenBallImage7.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 3.1)
            make.left.equalToSuperview().inset(view.frame.width / 4.7)
        }
        
        yellowBallImage8.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 3.1)
            make.right.equalToSuperview().inset(view.frame.width / 4.7)
        }
        
        yellowBallImage9.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 2.6)
            make.left.equalToSuperview().inset(view.frame.width / 3.5)
        }
        
        greenBallImage8.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 2.6)
            make.right.equalToSuperview().inset(view.frame.width / 3.5)
        }
        
        greenBallImage9.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 2.25)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        yellowBallImage10.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 2.05)
            make.right.equalToSuperview().inset(view.frame.width / 3.1)
        }
        
        greenBallImage10.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 2.05)
            make.left.equalToSuperview().inset(view.frame.width / 3.1)
        }
        
        yellowBallImage11.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().inset(view.frame.height / 1.85)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    //MARK: Set gesture
    private func setupGesture() {
        tapGesture.addTarget(self, action: #selector(handleTap))
        elkaImage.addGestureRecognizer(tapGesture)
    }
    
    //MARK: Create MovieView
    private func createMovieView() {
        movieView?.removeFromSuperview()
        let model = presenter?.getLoadedMovie()
        guard let model = model else { return }
        movieView = MovieView(model: model)
        
        view.addSubview(movieView!)
        movieView?.alpha = 0
        
        movieView!.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height / 3)
            make.width.equalTo(view.frame.width / 2)
            make.center.equalToSuperview()
        }
        
        movieView?.callBackButton = { [weak self] in
            self?.movieView?.alpha = 0
            self?.presenter?.routeToDetailVC()
        }
    }
    
    //MARK: Create close button
    private func createCloseButton() {
        view?.addSubview(closeMovieViewButton)
        guard let movieView = movieView else { return }
        
        closeMovieViewButton.snp.makeConstraints { make in
            make.size.equalTo(70)
            make.right.equalTo(movieView.snp.right).inset(-35)
            make.top.equalTo(movieView.snp.top).inset(-35)
        }
    }
    
    //MARK: Animation tagret
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        createMovieView()
        presenter?.fetchRequest()
        
        let tappedPoint = sender.location(in: elkaImage)
        
        if let tappedSubview = elkaImage.hitTest(tappedPoint, with: nil) as? BallView {
            
            UIView.animate(withDuration: 0.5, delay: .zero, options: [.curveEaseOut, .preferredFramesPerSecond60]) { [weak self] in
                guard let self = self else { return }
                if self.timer == nil {
                    self.timer = Timer.scheduledTimer(timeInterval: 0.075, target: self, selector: #selector(self.updateAnimation), userInfo: nil, repeats: true)
                }
                
                let transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                let rotateTransform = CGAffineTransform(rotationAngle: .greatestFiniteMagnitude)
                tappedSubview.transform = transform.concatenating(rotateTransform)
                tappedSubview.center = self.view.center
            } completion: { [weak self] _ in
                self?.closeMovieViewButton.alpha = 1.0
                UIView.animate(withDuration: 0.3, delay: 0) {
                    tappedSubview.updateImage(Constant.animation81)
                    
                    tappedSubview.snp.remakeConstraints {
                        $0.size.equalTo(200)
                        $0.center.equalToSuperview()
                    }
                    
                    self?.createCloseButton()
                    
                    self?.boomTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
                        guard let self = self, let presenter = presenter else { return }
                        if presenter.boomAnimationCount < 85 {
                            Task { tappedSubview.updateImage("\(Constant.animation)\(presenter.boomAnimationCount)") }
                            presenter.boomAnimationCount += 1
                        } else {
                            self.movieView?.alpha = 1.0
                            tappedSubview.removeFromSuperview()
                            self.boomTimer?.invalidate()
                            self.boomTimer = nil
                        }
                    })
                }
            }
        }
    }
    
    //MARK: Animation methods
    @objc private func updateAnimation() {
        guard let presenter = presenter else { return }
        if presenter.backgroundAnimationCount < 99 {
            Task { self.backgroungImage.image = UIImage(named: "\(Constant.confetti)\(presenter.backgroundAnimationCount)") }
            presenter.backgroundAnimationCount += 1
        } else {
            presenter.backgroundAnimationCount = 1
        }
    }
    
    //MARK: Update animation
    @objc private func updateAnimationBoom() {
        guard let presenter = presenter else { return }
        if presenter.boomAnimationCount < 85 {
            presenter.boomAnimationCount += 1
        }
    }
    
    //MARK: - Alert network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: Constant.requestError, message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: Close button target
    @objc private func tapCloseButton() {
        UIView.animate(withDuration: 0.25) {
            self.movieView?.alpha = 0.0
            self.closeMovieViewButton.alpha = 0.0
        }
    }
}


//MARK: - Extension ChristmasViewProtocol
extension ChristmasViewController: ChristmasViewProtocol {
    
    //MARK: Display request error
    func displayRequestError(error: RequestError) {
        Task { alertError(error) }
    }
}
