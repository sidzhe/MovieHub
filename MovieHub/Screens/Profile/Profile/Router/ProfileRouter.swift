//
//  ProfileRouter.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

final class ProfileRouter: ProfileRouterProtocol {
    func pushToEditProfile(from view: ProfileViewProtocol) {
        guard let view = view as? UIViewController else { return }
        let editProfileVC = Builder.createEditProfile()
        view.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    func pushToAboutUs(from view: ProfileViewProtocol) {
           guard let view = view as? UIViewController else { return }
           let policiesVC = AboutUsViewController()
           view.navigationController?.pushViewController(policiesVC, animated: true)
       }
       
       func pushToPolicies(from view: ProfileViewProtocol) {
           guard let view = view as? UIViewController else { return }
           let policiesVC = PoliciesViewController()
           view.navigationController?.pushViewController(policiesVC, animated: true)
       }

}
