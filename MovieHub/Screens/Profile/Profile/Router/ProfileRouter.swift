//
//  ProfileRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class ProfileRouter: ProfileRouterProtocol {
    func pushToLanguage(from view: ProfileViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let languageVC = LanguageViewController()
        view.navigationController?.pushViewController(languageVC, animated: true)
    }
    
    func pushToNotification(from view: ProfileViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let notificationVC = NotificationViewController()
        view.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    func pushToEditProfile(from view: ProfileViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let editProfileVC = Builder.createEditProfile()
        view.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    
    func pushToAboutUs(from view: ProfileViewProtocol) {
           guard let view = view as? UIViewController else { return }
           let aboutUsVC = AboutUsViewController()
           view.navigationController?.pushViewController(aboutUsVC, animated: true)
       }
       
       func pushToPolicies(from view: ProfileViewProtocol) {
           guard let view = view as? UIViewController else { return }
           let policiesVC = PoliciesViewController()
           view.navigationController?.pushViewController(policiesVC, animated: true)
       }

    func pushToAuth(from view: ProfileViewProtocol) {
        guard let view = view as? UIViewController else { return }
        view.dismiss(animated: true)
    }
}
