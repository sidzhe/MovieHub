//
//  AlertFactory.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 04.02.2024.
//

import UIKit

final class AlertFactory {
    static func makeLogoutConfirmationAlert(completion: @escaping (Bool) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Вы действительно хотите выйти?", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            completion(false)
        }
        let logoutAction = UIAlertAction(title: "Выйти", style: .destructive) { _ in
            completion(true) 
        }
        alert.addAction(cancelAction)
        alert.addAction(logoutAction)
        return alert
    }
    
    static func makeErrorAlert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        return alert
    }
}
