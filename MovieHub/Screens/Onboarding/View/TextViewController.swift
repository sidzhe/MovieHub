//
//  TextViewController.swift
//  MovieHub
//
//  Created by Dmitrii Dorogov on 11.01.2024.
//

import UIKit

class TextViewController: UIViewController {
    
    let textLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.backgroundColor = UIColor(red: 23/255, green: 24/255, blue: 36/255, alpha: 1)
        view.textColor = .white
        view.textAlignment = .center
        view.font = .montserratRegular(size: 14)
        return view
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
    
    init(imageName: String, titleText: String, buttonImage: String, subtitleText: String) {
        super.init(nibName: nil, bundle: nil)
        welcomeImage.image = UIImage(named: imageName)
        label.text = titleText
        textLabel.text = subtitleText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.welcomeImage)
        view.addSubview(self.label)
        view.addSubview(self.textLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(red: 23/255, green: 24/255, blue: 36/255, alpha: 1)
        
        textLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(150)
            make.height.equalTo(50)
        }
        
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(textLabel).inset(50)
            make.height.equalTo(50)
        }
        
        welcomeImage.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(label).inset(50)
            make.top.equalToSuperview()
        }
    }
}
