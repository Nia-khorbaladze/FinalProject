//
//  EmailOptionsViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import UIKit
import GoogleSignIn

final class EmailOptionsViewController: UIViewController {
    weak var delegate: EmailOptionsViewControllerDelegate?
    private let viewModel: GoogleSignInViewModel
    private let blurEffectService: BlurEffectService
    
    // MARK: - UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Your Email"
        label.font = Fonts.bold.uiFont(size: 24)
        label.textColor = UIColor(named: AppColors.white.rawValue)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add existing wallet or Create a new one"
        label.font = Fonts.regular.uiFont(size: 14)
        label.textColor = UIColor(named: AppColors.lightGrey.rawValue)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var continueWithGoogleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with Google", for: .normal)
        button.backgroundColor = UIColor(hexString: "343434")
        button.setTitleColor(UIColor(named: AppColors.white.rawValue), for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.continueWithGoogleTapped()
        }), for: .touchUpInside)
        
        return button
    }()

    private lazy var enterEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enter Email manually", for: .normal)
        button.setTitleColor(UIColor(named: AppColors.white.rawValue), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.enterEmailTapped()
        }), for: .touchUpInside)
        
        return button
    }()
    // MARK: - Initializers
    init(viewModel: GoogleSignInViewModel = Dependencies.shared.googleSignInViewModel, blurEffectService: BlurEffectService = BlurEffectService()) {
        self.viewModel = viewModel
        self.blurEffectService = blurEffectService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(continueWithGoogleButton)
        view.addSubview(enterEmailButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            continueWithGoogleButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16),
            continueWithGoogleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            continueWithGoogleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            continueWithGoogleButton.heightAnchor.constraint(equalToConstant: 50),
            
            enterEmailButton.topAnchor.constraint(equalTo: continueWithGoogleButton.bottomAnchor, constant: 16),
            enterEmailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Functions
    private func enterEmailTapped() {
        delegate?.didTapEnterEmailManually()
        dismiss(animated: true)
    }
    
    private func continueWithGoogleTapped() {
        viewModel.signInWithGoogle { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    let state: AuthenticationState = user.isNewUser ? .register : .login
                    self?.navigateToSuccessScreen(state: state)
                case .failure(let error):
                    self?.showErrorAlert(error: error)
                }
            }
        }
    }
    
    private func navigateToSuccessScreen(state: AuthenticationState) {
        let successAuthViewController = SuccessfulAuthViewController(state: state)
        navigationController?.pushViewController(successAuthViewController, animated: true)
    }
    
    private func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Error", message: "Something went wrong. Try again later.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Extensions
extension EmailOptionsViewController: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        blurEffectService.removeBlurEffect()
    }
}

