//
//  ButtonFactory.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 31.01.2024.
//

import UIKit

struct ButtonFactory {
    static func makeButton(title: String, color: UIColor, backgroundColor: UIColor, cornerRadius: CGFloat, action: @escaping () -> Void) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .montserratSemiBold(size: 16)
        button.setTitleColor(color, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        let uiAction = UIAction() { _ in
            action()
        }
        button.addAction(uiAction, for: .primaryActionTriggered)
        return button
    }
}
