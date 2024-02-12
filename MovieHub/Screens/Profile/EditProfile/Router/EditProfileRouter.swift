//
//  EditProfileRouter.swift
//  MovieHub
//
//  Created by Келлер Дмитрий on 03.02.2024.
//

import UIKit

final class EditProfileRouter: EditProfileRouterProtocol {
    func pushToAuth(from view: EditProfileViewProtocol) {
        guard let view = view as? UIViewController else { return }

        view.dismiss(animated: true)
    }
}
