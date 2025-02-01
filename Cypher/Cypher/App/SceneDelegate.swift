//
//  SceneDelegate.swift
//  Cypher
//
//  Created by Nkhorbaladze on 10.01.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let isLoggedIn = AuthManager.shared.isUserLoggedIn()
        
        window = UIWindow(windowScene: scene)
        
        if isLoggedIn {
            let tabBarController = TabBarController()
            window?.rootViewController = tabBarController
        } else {
            let welcomeViewController = WelcomeViewController()
            window?.rootViewController = UINavigationController(rootViewController: welcomeViewController)
        }
        
        window?.makeKeyAndVisible()
        
    }
}

