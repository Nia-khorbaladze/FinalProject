//
//  CredentialsInputViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import UIKit
import SwiftUI
import FirebaseAuth

final class CredentialsInputViewController: UIViewController {
    private let state: AuthenticationState
    private var email: String = ""
    private var password: String = ""
    private var confirmPassword: String = ""
    
    private var emailError: String?
    private var passwordError: String?
    private var confirmPasswordError: String?
    
    private let viewModel: CredentialsInputViewModel
    private var buttonBottomConstraint: NSLayoutConstraint!
    private var keyboardHandler: KeyboardHandler?
    
    // MARK: - UI Elements
    private lazy var emailField: UIHostingController<InputView> = {
        let hostingController = UIHostingController(
            rootView: InputView(
                text: Binding(
                    get: { [weak self] in self?.email ?? "" },
                    set: { [weak self] value in self?.email = value }
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
                    get: { [weak self] in self?.password ?? "" },
                    set: { [weak self] value in self?.password = value }
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
                    get: { [weak self] in self?.confirmPassword ?? "" },
                    set: { [weak self] value in self?.confirmPassword = value }
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
                action: { [weak self] in self?.authenticate() }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var navigateBackButton: UIButton = {
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
        let authRepository = FirebaseAuthRepository()
        let loginUseCase = LoginUseCase(repository: authRepository)
        let registerUseCase = RegisterUseCase(repository: authRepository)
        self.viewModel = CredentialsInputViewModel(loginUseCase: loginUseCase, registerUseCase: registerUseCase)
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
        setupConstraints()
        
        keyboardHandler = KeyboardHandler(view: view, bottomConstraint: buttonBottomConstraint, bottomOffset: 20)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.addSubview(emailField.view)
        emailField.didMove(toParent: self)
        
        view.addSubview(passwordField.view)
        passwordField.didMove(toParent: self)
        
        if let confirmPasswordField = confirmPasswordField {
            view.addSubview(confirmPasswordField.view)
            confirmPasswordField.didMove(toParent: self)
        }
        
        view.addSubview(continueButton.view)
        continueButton.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        buttonBottomConstraint = continueButton.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([
            emailField.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailField.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordField.view.topAnchor.constraint(equalTo: emailField.view.bottomAnchor, constant: 20),
            passwordField.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            buttonBottomConstraint,
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
    private func validateFields(_ errors: [ValidationError]) {
        emailError = errors.contains(.email) || errors.contains(.emailEmpty)
        ? errors.contains(.email) ? ValidationError.email.errorDescription : ValidationError.emailEmpty.errorDescription
        : nil
        
        passwordError = errors.contains(.password) || errors.contains(.passwordEmpty)
        ? errors.contains(.password) ? ValidationError.password.errorDescription : ValidationError.passwordEmpty.errorDescription
        : nil
        
        confirmPasswordError = state == .register && (errors.contains(.confirmPassword) || errors.contains(.confirmPasswordEmpty))
        ? errors.contains(.confirmPassword) ? ValidationError.confirmPassword.errorDescription : ValidationError.confirmPasswordEmpty.errorDescription
        : nil
        
        updateUIWithErrors()
    }
    
    private func authenticate() {
        let confirmPasswordForValidation: String? = state == .register ? confirmPassword : nil
        
        viewModel.authenticate(
            email: email,
            password: password,
            confirmPassword: confirmPasswordForValidation,
            isRegistration: state == .register
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.navigateToSuccessScreen(for: user)
                case .failure(let error):
                    if case AuthError.emailAlreadyInUse = error {
                        self?.showErrorAlert()
                    } else if let validationErrors = error as? ValidationErrors {
                        self?.validateFields(validationErrors.errors)
                    }
                }
            }
        }
    }
    
    private func navigateToSuccessScreen(for user: User) {
        let walletAddressUseCase = Dependencies.shared.saveWalletAddressUseCase
        let successfulAuthViewModel = SuccessfulAuthViewModel(walletAddressUseCase: walletAddressUseCase)
        
        let successAuthViewController = SuccessfulAuthViewController(state: self.state, viewModel: successfulAuthViewModel)
        navigationController?.pushViewController(successAuthViewController, animated: true)
    }

    private func updateUIWithErrors() {
        emailField.rootView.errorText = emailError
        passwordField.rootView.errorText = passwordError
        confirmPasswordField?.rootView.errorText = confirmPasswordError
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
