//
//  WelcomeViewController.swift
//  Cypher
//
//  Created by Nkhorbaladze on 11.01.25.
//

import Foundation
import UIKit
import SwiftUI

final class WelcomeViewController: UIViewController {
    private let viewModel: AuthenticationViewModel
    
    // MARK: - UI Elements
    private lazy var welcomeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Icons.welcomeImage.rawValue)
        imageView.heightAnchor.constraint(equalToConstant: 355).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var welcomeText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.bold.uiFont(size: 26)
        label.text = "Welcome to Cypher"
        label.textColor = UIColor(named: AppColors.white.rawValue)
        
        return label
    }()
    
    private lazy var welcomeSubtext: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.regular.uiFont(size: 16)
        label.text = "To get started, create a new wallet or import an existing one."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(named: AppColors.lightGrey.rawValue)
        
        return label
    }()
    
    private lazy var termsOfAgreementContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var agreementButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(agreementButtonTapped), for: .touchUpInside)

        return button
    }()
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = NSMutableAttributedString(string: "I agree to the ", attributes: [
            .foregroundColor: UIColor(named: AppColors.white.rawValue) ?? .white,
            .font: Fonts.semiBold.uiFont(size: 15)
        ])
        text.append(NSAttributedString(string: "Terms of Service", attributes: [
            .foregroundColor: UIColor(named: AppColors.accent.rawValue) ?? .white,
            .font: Fonts.semiBold.uiFont(size: 15)
        ]))
        label.attributedText = text
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var createWalletButton: UIHostingController<PrimaryButton> = {
        let hostingController = UIHostingController(
            rootView: PrimaryButton(
                title: "Create a new wallet",
                isActive: false,
                action: { self.CreateWalletButtonTapped() }
            )
        )
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        return hostingController
    }()
    
    private lazy var alredyHaveAWalletButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("I already have a wallet", for: .normal)
        button.titleLabel?.font = Fonts.bold.uiFont(size: 15)
        button.titleLabel?.textColor = UIColor(named: AppColors.white.rawValue)
        button.addTarget(self, action: #selector(alredyHaveAWalletButtonTapped), for: .touchUpInside)

        return button
    }()
    
    // MARK: - Initializers
    init(viewModel: AuthenticationViewModel = AuthenticationViewModel(state: .login)) {
        self.viewModel = viewModel
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - UI Setup
    private func setup() {
        view.backgroundColor = UIColor(named: AppColors.backgroundColor.rawValue)
        setupUI()
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(termsTapped))
        termsLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        view.addSubview(welcomeImage)
        view.addSubview(welcomeText)
        view.addSubview(welcomeSubtext)
        view.addSubview(termsOfAgreementContainer)
        termsOfAgreementContainer.addSubview(agreementButton)
        termsOfAgreementContainer.addSubview(termsLabel)
        addChild(createWalletButton)
        view.addSubview(createWalletButton.view)
        createWalletButton.didMove(toParent: self)
        view.addSubview(alredyHaveAWalletButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcomeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35),
            welcomeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            welcomeText.topAnchor.constraint(equalTo: welcomeImage.bottomAnchor, constant: 65),
            welcomeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            welcomeSubtext.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 5),
            welcomeSubtext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            welcomeSubtext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            welcomeSubtext.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            agreementButton.leadingAnchor.constraint(equalTo: termsOfAgreementContainer.leadingAnchor),
            agreementButton.topAnchor.constraint(equalTo: termsOfAgreementContainer.topAnchor),
            agreementButton.bottomAnchor.constraint(equalTo: termsOfAgreementContainer.bottomAnchor),
            termsLabel.leadingAnchor.constraint(equalTo: agreementButton.trailingAnchor, constant: 5),
            termsLabel.trailingAnchor.constraint(equalTo: termsOfAgreementContainer.trailingAnchor),
            termsLabel.topAnchor.constraint(equalTo: termsOfAgreementContainer.topAnchor),
            termsLabel.bottomAnchor.constraint(equalTo: termsOfAgreementContainer.bottomAnchor),
            termsLabel.centerYAnchor.constraint(equalTo: agreementButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termsOfAgreementContainer.topAnchor.constraint(equalTo: welcomeSubtext.bottomAnchor, constant: 65),
            termsOfAgreementContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createWalletButton.view.topAnchor.constraint(equalTo: termsOfAgreementContainer.bottomAnchor, constant: 20),
            createWalletButton.view.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            alredyHaveAWalletButton.topAnchor.constraint(equalTo: createWalletButton.view.bottomAnchor, constant: 15),
            alredyHaveAWalletButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - Functions
    @objc private func termsTapped() {
        let termsViewController = TermsViewController()
        navigationController?.present(termsViewController, animated: true)
    }
    
    @objc private func CreateWalletButtonTapped() {
        viewModel.updateState(to: .register)
    }
    
    @objc private func alredyHaveAWalletButtonTapped() {
        viewModel.updateState(to: .login)
    }
    
    @objc private func agreementButtonTapped() {
        viewModel.toggleAgreement()
        updateAgreementButtonAppearance()
        updateCreateWalletButton()
    }
    
    private func updateAgreementButtonAppearance() {
        let imageName = viewModel.isAgreementAccepted ? "checkmark.circle.fill" : "circle"
        agreementButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private func updateCreateWalletButton() {
        createWalletButton.rootView = PrimaryButton(
            title: "Create a new wallet",
            isActive: viewModel.isCreateWalletButtonActive,
            action: { self.CreateWalletButtonTapped() }
        )
    }
    
}
