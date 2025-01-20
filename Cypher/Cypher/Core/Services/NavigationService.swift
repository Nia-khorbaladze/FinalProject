//
//  NavigationService.swift
//  Cypher
//
//  Created by Nkhorbaladze on 20.01.25.
//

import UIKit

final class NavigationService: NavigationServiceProtocol {
    static let shared = NavigationService()
    
    private init() {}
    
    func switchToMainInterface() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let tabBarController = TabBarController()
                UIView.transition(with: window,
                                duration: 0.3,
                                options: .transitionCrossDissolve,
                                animations: {
                    window.rootViewController = tabBarController
                })
            }
        }
    }
    
    func switchToAuth() {
        DispatchQueue.main.async {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                let welcomeViewController = WelcomeViewController()
                UIView.transition(with: window,
                                duration: 0.3,
                                options: .transitionCrossDissolve,
                                animations: {
                    window.rootViewController = UINavigationController(rootViewController: welcomeViewController)
                })
            }
        }
    }
}
