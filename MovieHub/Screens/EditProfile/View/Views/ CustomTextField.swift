//
//  CustomTextField.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 13.01.2024.
//

import UIKit

final class  CustomTextField: UIView {
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 24
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var infoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    init(placeholder: String, labelText: String) {
        super.init(frame: .zero)
        setupSubviews(placeholder: placeholder, labelText: labelText)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews(placeholder: "", labelText: "")
        setConstraints()
    }
    
    private func setupSubviews(placeholder: String, labelText: String) {
      addSubview(backgroundView)
      backgroundView.addSubview(infoBackgroundView)
      backgroundView.addSubview(textField)
      infoBackgroundView.addSubview(infoLabel)
      textField.placeholder = placeholder
      infoLabel.text = labelText
    }
    
    private func setConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
        
        infoBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(-27)
            make.width.equalTo(100)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
    }
}
