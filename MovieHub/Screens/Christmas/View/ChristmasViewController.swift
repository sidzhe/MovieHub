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
    private var count = 0
    private var count2 = 82
    
    //MARK: - UI Elements
    private let elkaImage = UIImageView(image:  UIImage(named: "elka")!)
    private let yellowBallImage = UIImageView(image: UIImage(named: "yellowBall"))
    private let greenBallImage = UIImageView(image: UIImage(named: "greenBall"))
    private let backgroungImage = UIImageView()
    
    private lazy var yellowBallButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(tapBall), for: .touchUpInside)
        return button
    }()
    
    private lazy var greenBallButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(tapBall), for: .touchUpInside)
        return button
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryDark
        elkaImage.backgroundColor = .clear
        
        view.addSubview(backgroungImage)
        view.addSubview(elkaImage)
        view.addSubview(yellowBallImage)
        view.addSubview(greenBallImage)
        view.addSubview(yellowBallButton)
        view.addSubview(greenBallButton)
        
        backgroungImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        elkaImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.bottom.equalToSuperview().inset(90)
        }
        
        yellowBallImage.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.center.equalToSuperview()
        }
        
        greenBallImage.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.top.equalTo(yellowBallImage.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        
        yellowBallButton.snp.makeConstraints { make in
            make.center.equalTo(yellowBallImage.snp.center)
            make.size.equalTo(50)
        }
        
        greenBallButton.snp.makeConstraints { make in
            make.center.equalTo(greenBallImage.snp.center)
            make.size.equalTo(50)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer?.invalidate()
        boomTimer?.invalidate()
        boomTimer = nil
        timer = nil
        backgroungImage.image = nil
        
    }
    
    @objc private func tapBall(_ sender: UIButton) {
        print("tap tap")
        
        UIView.animate(withDuration: 0.5, delay: .zero, options: [.curveEaseOut, .preferredFramesPerSecond60]) {
            self.timer = Timer.scheduledTimer(timeInterval: 0.075, target: self, selector: #selector(self.updateAnimation), userInfo: nil, repeats: true)
            let transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
            let rotateTransform = CGAffineTransform(rotationAngle: .greatestFiniteMagnitude)
            self.yellowBallImage.transform = transform.concatenating(rotateTransform)
            self.yellowBallImage.center = self.view.center
        } completion: { [weak self] _ in

            UIView.animate(withDuration: 0.3, delay: 0) {
                
                self?.yellowBallImage.image = UIImage(named: "animation81")
                
                self?.yellowBallImage.snp.remakeConstraints {
                    $0.size.equalTo(200)
                    $0.center.equalToSuperview()
                }
                
                self?.boomTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self?.updateAnimationBoom), userInfo: nil, repeats: true)
            }
        }
    }
    
    @objc private func updateAnimation() {
        if count < 99 {
            Task { self.backgroungImage.image = UIImage(named: "confetti-27-\(self.count)") }
            count += 1
        } else {
            count = 1
        }
    }
    
    @objc private func updateAnimationBoom() {
        if count2 < 85 {
            Task { self.yellowBallImage.image = UIImage(named: "animation\(self.count2)") }
            count2 += 1
        } else {
            self.yellowBallImage.isHidden = true
        }
    }
}


//MARK: - Extension ChristmasViewProtocol
extension ChristmasViewController: ChristmasViewProtocol {
    
}
