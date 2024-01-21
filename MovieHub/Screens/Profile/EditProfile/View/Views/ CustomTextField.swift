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
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratMedium(size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .primaryDark
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
        backgroundView.addSubview(textField)
        addSubview(infoLabel)
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
        
        infoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.centerY.equalToSuperview().offset(-27)
            make.width.equalTo(100)
        }
        
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-48)
            make.height.equalTo(53)
        }
    }
}
