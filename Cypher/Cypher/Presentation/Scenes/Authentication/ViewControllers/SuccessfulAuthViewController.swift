//
//  SuccessfulAuthViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 13.01.25.
//

import UIKit
import SwiftUI

final class SuccessfulAuthViewController: UIViewController {
    private let state: AuthenticationState
    
    // MARK: - UI Elements
    private lazy var authView: UIHostingController<SuccessfulAuthView> = {
        let title = state == .register ? "You're all done!" : "Login Successful!"
        let subtitle = state == .register ? "You can now fully enjoy your wallet." : "Welcome back! Your wallet is ready to go."
        let hostingController = UIHostingController(
            rootView: SuccessfulAuthView(successMessageTitle: title, successMessageSubTitle: subtitle)
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var continueButton: UIHostingController<PrimaryButton> = {
        let title = state == .register ? "Get Started" : "Let's Go"
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Get Started",
                isActive: true,
                action: { self.navigate() }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    // MARK: - Initializers
    init(state: AuthenticationState) {
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setup()
    }
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addChild(authView)
        view.addSubview(authView.view)
        authView.didMove(toParent: self)
        
        addChild(continueButton)
        view.addSubview(continueButton.view)
        continueButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            authView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            authView.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func navigate() {
        let factory = ViewControllerFactory()
        navigationController?.pushViewController(factory.makeHomePageViewController(), animated: true)
    }
}
