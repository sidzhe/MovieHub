//
//  SceneDelegate.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let storageService = StorageService()
        let currentUser = storageService.checkCurrentUser()
        
        if UserDefaults.standard.value(forKey: "state") != nil {
            if currentUser {
                window?.rootViewController = Builder.createTabBar()
            } else {
                let authVC = Builder.createAuth()
                let navigationController = UINavigationController(rootViewController: authVC)
                window?.rootViewController = navigationController
            }
        } else {
            window?.rootViewController = Builder.createOnboarding()
        }
        
        window?.makeKeyAndVisible()
    }
}

