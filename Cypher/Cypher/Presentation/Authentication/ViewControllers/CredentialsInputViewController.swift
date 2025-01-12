//
//  CredentialsInputViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import UIKit
import SwiftUI
import Combine

final class CredentialsInputViewController: UIViewController {
    private let state: AuthenticationState
    private var email: String = ""
    private var password: String = ""
    private var confirmPassword: String = ""
    
    private var emailError: String?
    private var passwordError: String?
    private var confirmPasswordError: String?
    
    private let viewModel = CredentialsInputViewModel()
    
    // MARK: - UI Elements
    private lazy var emailField: UIHostingController<InputView> = {
        let hostingController = UIHostingController(
            rootView: InputView(
                text: Binding(
                    get: { self.email },
                    set: { self.email = $0 }
                ),
                title: "Email",
                placeholder: "Enter your email",
                inputFieldIcon: "envelope"
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var passwordField: UIHostingController<InputView> = {
        let hostingController = UIHostingController(
            rootView: InputView(
                text: Binding(
                    get: { self.password },
                    set: { self.password = $0 }
                ),
                title: "Password",
                placeholder: "Enter your password",
                isSecureField: true,
                inputFieldIcon: "lock"
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var confirmPasswordField: UIHostingController<InputView>? = {
        guard state == .register else { return nil }
        let hostingController = UIHostingController(
            rootView: InputView(
                text: Binding(
                    get: { self.confirmPassword },
                    set: { self.confirmPassword = $0 }
                ),
                title: "Confirm Password",
                placeholder: "Confirm your password",
                isSecureField: true,
                inputFieldIcon: "lock"
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var continueButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Continue",
                isActive: true,
                action: { self.navigate() }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private let navigateBackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.isEnabled = true
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        
        return button
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
        setup()
    }
    
    // MARK: - Setup UI
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupBackButton()
    }
    
    private func setupUI() {
        addChild(emailField)
        view.addSubview(emailField.view)
        emailField.didMove(toParent: self)
        
        addChild(passwordField)
        view.addSubview(passwordField.view)
        passwordField.didMove(toParent: self)
        
        if let confirmPasswordField = confirmPasswordField {
            addChild(confirmPasswordField)
            view.addSubview(confirmPasswordField.view)
            confirmPasswordField.didMove(toParent: self)
        }
        
        addChild(continueButton)
        view.addSubview(continueButton.view)
        continueButton.didMove(toParent: self)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailField.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailField.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordField.view.topAnchor.constraint(equalTo: emailField.view.bottomAnchor, constant: 20),
            passwordField.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            continueButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.view.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        if let confirmPasswordField = confirmPasswordField {
            NSLayoutConstraint.activate([
                confirmPasswordField.view.topAnchor.constraint(equalTo: passwordField.view.bottomAnchor, constant: 20),
                confirmPasswordField.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                confirmPasswordField.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }
    }
    
    private func setupBackButton() {
        navigateBackButton.addAction(UIAction(handler: { [weak self] _ in
            self?.navigateBack()
        }), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigateBackButton)
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    private func navigate() {
        let errors = viewModel.validateFields(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            isRegistration: state == .register
        )
        
        emailError = errors.contains(.email) ? ValidationError.email.errorDescription : nil
        emailError = errors.contains(.emailEmpty) ? ValidationError.emailEmpty.errorDescription : emailError
        
        passwordError = errors.contains(.password) ? ValidationError.password.errorDescription : nil
        passwordError = errors.contains(.passwordEmpty) ? ValidationError.passwordEmpty.errorDescription : passwordError
        
        if state == .register {
            confirmPasswordError = errors.contains(.confirmPassword) ? ValidationError.confirmPassword.errorDescription : nil
            confirmPasswordError = errors.contains(.confirmPasswordEmpty) ? ValidationError.confirmPasswordEmpty.errorDescription : confirmPasswordError
        }
        
        updateUIWithErrors()
        
        guard errors.isEmpty else { return }
        
        let successAuthViewController = SuccessfulAuthViewController(state: state)
        navigationController?.pushViewController(successAuthViewController, animated: true)
    }


    private func updateUIWithErrors() {
        emailField.rootView.errorText = emailError
        passwordField.rootView.errorText = passwordError
        confirmPasswordField?.rootView.errorText = confirmPasswordError
    }

}
